import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import {
    DiamondCutFacet,
    GroupManagerFacet,
    RegistryFacet,
    } from "../../typechain-types";
import {
    getSelectors,
    FacetCutAction,
    } from "../../scripts/libraries/diamond";
import { assert, expect } from "chai";

export interface IngesterControllerMapping {
    [ingesterAddress: string]: SignerWithAddress;
}

export interface IngesterToGroups {
    [ingesterAddress: string]: string[];
}

export function allUnique(arr: number[]): boolean {
    const set = new Set(arr);
    return set.size === arr.length;
}

export async function addRegistrationFacet(addresses: string[], diamondCutFacet: DiamondCutFacet) {
    const RegisteryFacet = await ethers.getContractFactory("RegistryFacet");
    const registryFacet = await RegisteryFacet.deploy();
    await registryFacet.deployed();
    addresses.push(registryFacet.address);
    const selectors = getSelectors(registryFacet);

    let tx = await diamondCutFacet.diamondCut(
    [
        {
        facetAddress: registryFacet.address,
        action: FacetCutAction.Add,
        functionSelectors: selectors,
        },
    ],
    ethers.constants.AddressZero,
    "0x",
    { gasLimit: 800000 }
    );
    let receipt = await tx.wait();
    if (!receipt.status) {
    throw Error(`Diamond upgrade failed: ${tx.hash}`);
    }
    return registryFacet;
}

export async function addFacetsToDiamond(addresses: string[], diamondCutFacet: DiamondCutFacet, diamondAddress: string, FacetNames: string[]) {
    let accessControlFacet = await ethers.getContractFactory("AccessControlFacet");
    let accessControlFacetSelectors = getSelectors(accessControlFacet);

    let commonFunctionsFacet = await ethers.getContractFactory("CommonFunctionsFacet");
    let commonFunctionSelectors = getSelectors(commonFunctionsFacet);

    FacetNames = [...FacetNames, "AccessControlFacet", "CommonFunctionsFacet"];
    const facetCuts = [];
    let selectorsAdded: any= [];
    for (const FacetName of FacetNames) {
        const Facet = await ethers.getContractFactory(FacetName);
        const facet = await Facet.deploy();
        await facet.deployed();
        addresses.push(facet.address);
        // console.log(`${FacetName} deployed: ${facet.address}`);
        
        let selectorsToAdd = getSelectors(facet);
        if (FacetName != 'AccessControlFacet') {
            let accessControlFacetSelectors = getSelectors(accessControlFacet);
            //filter out AccessControlFacet since all other facets extend this
            selectorsToAdd = selectorsToAdd.filter(
                (selector: any) => !accessControlFacetSelectors.includes(selector)
                );
        }
        if (FacetName != 'CommonFunctionsFacet') {
            let commonFunctionSelectors = getSelectors(commonFunctionsFacet);
            // filter out Common Functions Facet since all other facets extend this
            selectorsToAdd = selectorsToAdd.filter(
                (selector: any) => !commonFunctionSelectors.includes(selector)
                );
        }
        selectorsAdded.push(...selectorsToAdd);
        facetCuts.push({
            facetAddress: facet.address,
            action: FacetCutAction.Add,
            functionSelectors: selectorsToAdd,
        });
    }
    // let diff = selectorsAdded.filter((facet) => !defaultFacets.includes(facet));

    let txDiamond = await diamondCutFacet.diamondCut(
        facetCuts,
        ethers.constants.AddressZero,
        "0x",
        { gasLimit: 30000000 }
    );
    let receiptTx = await txDiamond.wait();
    if (!receiptTx.status) {
        throw Error(`Diamond upgrade failed: ${txDiamond.hash}`);
    }

    return addresses;
}

export async function checkClusterIsWithinConstraints(groupManagerFacet: GroupManagerFacet, registryFacet: RegistryFacet, maxClusterSize: number) {
    //check each cluster is within constraints
    let clusterIds = await groupManagerFacet.getClusters();
    let getMaxGroupsPerIngester = BigNumber.from(await groupManagerFacet.getMaxGroupsPerIngester()).toNumber();
    for (let i = 0; i < clusterIds.length; i++) {
        let cluster = await groupManagerFacet.getCluster(clusterIds[i]);

        //Calculate the inner cluster contraint for this particular cluster
        let clusterGroupCount = BigNumber.from(cluster.clusterGroupCount).toNumber();
        let maxGroupsPerIngesterWithinCluster = Math.ceil((clusterGroupCount + cluster.ingesterAddresses.length -1) / cluster.ingesterAddresses.length);
        
        let ingesterToGroup: IngesterToGroups = {};
        let clusterGroups: string[] = []
        for (let j = 0; j < cluster.ingesterAddresses.length; j++ ) {
            let ingester = await registryFacet.getIngesterWithGroups(cluster.ingesterAddresses[j]);
            ingesterToGroup[ingester.ingesterAddress] = ingester.assignedGroups;
            clusterGroups = clusterGroups.concat(ingester.assignedGroups);
            
            for (let z = 0; z < ingester.assignedGroups.length; z++){
                let group = await groupManagerFacet.getGroup(ingester.assignedGroups[z]);
                expect(group.ingesterAddresses).includes(cluster.ingesterAddresses[j]);
            } 
            expect(ingester.assignedGroups.length <= maxGroupsPerIngesterWithinCluster);
        }
        
        let maxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
        for (let j = 0; j < clusterGroups.length; j++ ) {
            let group = await groupManagerFacet.getGroup(clusterGroups[j]);
            expect(group.ingesterAddresses.length <= maxNumberIngesterPerGroup);
        }
        //check that the amount of addresses per group abides by the global constraint
        expect(cluster.ingesterAddresses.length < maxClusterSize);
        //Check that the amount of groups is lower than the global constraint
        expect(clusterGroups.length < getMaxGroupsPerIngester);
    }

}

export async function getClusterMaxGroupsPerIngester(groupManagerFacet: GroupManagerFacet, clusterId: number) {
    let clusterDetails = await groupManagerFacet.getCluster(clusterId);
    let clusterGroupCount = BigNumber.from(clusterDetails.clusterGroupCount).toNumber();
    let clusterIngesterCount = BigNumber.from(clusterDetails.ingesterAddresses.length).toNumber();
    let maxGroupsPerIngesterAfterUnregistering = (clusterGroupCount + clusterIngesterCount - 1) / clusterIngesterCount;
    return maxGroupsPerIngesterAfterUnregistering
}