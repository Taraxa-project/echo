FROM node:16
RUN git clone https://github.com/oceanprotocol/ocean-subgraph.git /usr/app/subgraph
WORKDIR /usr/app/subgraph
RUN npm ci --legacy-peer-deps
# RUN npm run build
# EXPOSE 3000
CMD ["npm", "run", "quickstart:mumbai"]
