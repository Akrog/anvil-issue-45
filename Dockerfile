FROM anvil:6.0
COPY Material_Design_1 /apps/Material_Design_1
ENTRYPOINT ["anvil-app-server", "--data-dir", "/anvil-data", "--app", "Material_Design_1"]
