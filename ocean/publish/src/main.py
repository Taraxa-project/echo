import json, requests, logging, web3, os, time, datetime

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('publish')
ipfs_request_sleep = 2.0

def write_file(data_type, session, ipfs_uri, date_min, date_max, hashes_meta_all):
    file_name = data_type + '.json_lines'
    ingester_count = len(hashes_meta_all)
    with open(file_name, 'w') as f:
        do_write_column_names = True
        ingester_index = 0
        for ingester, hashes_meta in hashes_meta_all.items():
            ingester_index += 1

            (user_meta, chat_meta, message_meta) = hashes_meta
            if data_type == 'message':
                hash_meta = message_meta
            elif data_type == 'user':
                hash_meta = user_meta
            else:
                hash_meta = chat_meta
            
            uri_meta = ipfs_uri + '/api/v0/cat?&arg=' + hash_meta
            response_meta = session.post(uri_meta)
            if response_meta.status_code != 200:
                logger.warning(f'{uri_meta}: {response_meta.status_code} {response_meta.content}')
                time.sleep(ipfs_request_sleep)
                continue
            time.sleep(ipfs_request_sleep)
            
            content_meta = response_meta.text
            lines_json_meta = content_meta.splitlines()
            lines_json_meta.pop(0)

            for line_json_meta in lines_json_meta:
                line_meta = json.loads(line_json_meta)

                if data_type != 'chat':
                    date = line_meta[1]
                    if date < date_min or date > date_max:
                        continue
                hash_data = line_meta[0]

                if data_type != 'chat':
                    logger.info(f'[{ingester_index}/{ingester_count}][{ingester}][{data_type}][{hash_data}][{date}]')
                else:
                    logger.info(f'[{ingester_index}/{ingester_count}][{ingester}][{data_type}][{hash_data}]')

                response_data = session.post(ipfs_uri + '/api/v0/cat?&arg=' + hash_data)
                if response_data.status_code != 200:
                    logger.warning(f'{uri_meta}: {response_meta.status_code} {response_meta.content}')
                    time.sleep(ipfs_request_sleep)
                    continue
                time.sleep(ipfs_request_sleep)

                content_data = response_data.text
                lines_json_data = content_data.splitlines(keepends=True)
                if do_write_column_names:
                    do_write_column_names = False
                    f.writelines(lines_json_data)
                else:
                    lines_json_data.pop(0)
                    f.writelines(lines_json_data)

def read_hashes_meta_all(rpc_endpoint, contract_address):

    w3 = web3.Web3(web3.Web3.HTTPProvider(rpc_endpoint))

    with open('contract_interface_data_gathering.abi', 'r') as f:
        abi_common_functions = json.load(f)
    contract_common_functions = w3.eth.contract(contract_address, abi=abi_common_functions)

    logger.info('reading ingester addresses')

    getIngesters = contract_common_functions.functions['getIngesters']
    ingesters = getIngesters().call()

    with open('contract_interface_data_gathering.abi', 'r') as f:
        abi_data_gathering = json.load(f)

    contract_data_gathering= w3.eth.contract(contract_address, abi=abi_data_gathering)

    get_ipfs_hashes = contract_data_gathering.functions['getIpfsHashes']
 
    logger.info('reading meta hashes')

    hashes_meta_all = {}
    for ingester in ingesters:
        hashes_meta_all[ingester] = get_ipfs_hashes(ingester).call()

    return hashes_meta_all

# def ocean_setup_publish():
# # Create Ocean instance
#     from ocean_lib.example_config import get_config_dict
#     config = get_config_dict("http://localhost:8545")

#     from ocean_lib.ocean.ocean import Ocean
#     ocean = Ocean(config)

#     # Create OCEAN object. Barge auto-created OCEAN, and ocean instance knows
#     OCEAN = ocean.OCEAN_token

#     # Mint fake OCEAN to Alice & Bob
#     from ocean_lib.ocean.mint_fake_ocean import mint_fake_OCEAN
#     mint_fake_OCEAN(config)

#     # Create Alice's wallet
#     import os
#     from eth_account import Account

#     alice_private_key = os.getenv("TEST_PRIVATE_KEY1")
#     alice = Account.from_key(private_key=alice_private_key)
#     # assert alice.balance() > 0, "Alice needs ETH"
#     assert OCEAN.balanceOf(alice) > 0, "Alice needs OCEAN"

#     # Create additional wallets. While some flows just use Alice wallet, it's simpler to do all here.
#     bob_private_key = os.getenv('TEST_PRIVATE_KEY2')
#     bob = Account.from_key(private_key=bob_private_key)
#     # assert bob.balance() > 0, "Bob needs ETH"
#     assert OCEAN.balanceOf(bob) > 0, "Bob needs OCEAN"

#     # Compact wei <> eth conversion
#     from ocean_lib.ocean.util import to_wei, from_wei

#     #data info
#     name = "Price not working"
#     url = "https://raw.githubusercontent.com/trentmc/branin/main/branin.arff"

#     #create data asset
#     from ocean_lib.models.fixed_rate_exchange import ExchangeArguments
#     # (data_nft, datatoken, ddo) = ocean.assets.create_url_asset(name, url, {"from": alice},)

#     (data_nft, datatoken, ddo) = ocean.assets.create_url_asset(
#         name,
#         url,
#         {"from": alice},
#         pricing_schema_args=ExchangeArguments(
#             rate=to_wei(3),
#             base_token_addr=ocean.OCEAN_address,
#             dt_decimals=18)
#     )

#     #print
#     print("Just published asset:")
#     print(f"  data_nft: symbol={data_nft.symbol()}, address={data_nft.address}")
#     print(f"  datatoken: symbol={datatoken.symbol()}, address={datatoken.address}")
#     print(f"  metadata={ddo.metadata}")
#     print(f"  did={ddo.did}")

def main():

    rpc_endpoint = os.environ['RPC_ENDPOINT']
    contract_address = os.environ['CONTRACT_ADDRESS']
 
    hashes_meta_all = read_hashes_meta_all(rpc_endpoint, contract_address)

    session = requests.Session()
    ipfs_uri = os.environ['IPFS_URI']
    ipfs_username = os.environ['IPFS_USERNAME']
    ipfs_password = os.environ['IPFS_PASSWORD']
    session.auth = (ipfs_username, ipfs_password)
  
    yesterday = datetime.datetime.today() - datetime.timedelta(days=1)
    yesterday_fmt = yesterday.strftime('%Y-%m-%d')
    date_min = yesterday_fmt
    date_max = yesterday_fmt

    write_file('message', session, ipfs_uri, date_min, date_max, hashes_meta_all)
    write_file('user', session, ipfs_uri, date_min, date_max, hashes_meta_all)
    write_file('chat', session, ipfs_uri, date_min, date_max, hashes_meta_all)

    # ocean_setup_publish()

main()