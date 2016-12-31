FROM microsoft/aspnetcore

COPY dotnet-bin /app

WORKDIR /app

EXPOSE 5000/tcp

CMD ["dotnet", "hello.dll"]
