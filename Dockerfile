FROM mcr.microsoft.com/dotnet/sdk:7.0 as build-env
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY . ./
RUN dotnet restore
COPY . ./
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/sdk:7.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "ci-cd-api.dll"]

#docker build -t kubapi . #run this command again if you want to update the container with your latest code
#Use a specific port that runs the application in the container
#docker run -p 8082:80 -e ASPNETCORE_URLS=http://+:80 mydemo
#docker build . -t esataydin/kubapi:v1
#docker push esataydin/kubapi:v1
#kubectl get all
#kubectl apply -f deployment.yaml # goes into kubernetes ci and apply then deployment file
#kubectl delete -f deployment.yaml

#dcoker ps # see running docker images
#docker logs <container-id>
#docker stop 7a5aac75fb2d  # Stop the current container
#docker run -d -p 8080:5000 my-cicd-app:v1  # Create a new container with port mapping
