#by using a builder alias we are saying the first phase would be called as a builder phase
#sole purpose of this phase is install our dependancies and build our application.
FROM node:16-alpine as builder
WORKDIR '/home/node/app'  
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#second phase FROM of this block essentially is going to terminate previous FROM block
FROM nginx
#expose instruction does nothing for us automatically but aws elasticbeanstalk would look for this instruction and map port 80 
EXPOSE 80 
#this copy command will tell we want to copy from previous builder phase
COPY --from=builder /home/node/app/build /usr/share/nginx/html






