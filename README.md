# Awscodepipe


Este projeto demonstra como criar uma pipeline de código usando GitHub Actions, Terraform e AWS para automatizar a implantação e gerenciamento de recursos de infraestrutura na nuvem.

## Estrutura do projeto

```bash
.
├── .github
│   └── workflows
│       └── main.yml
├── terraform
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── backend.tf
└── README.md
```

Este projeto utiliza o GitHub Actions para realizar a **Integração Contínua (CI)** e **Implantação Contínua (CD)**. O arquivo de configuração do fluxo de trabalho, chamado `main.yml`, está localizado na pasta `.github/workflows`. O fluxo de trabalho é ativado toda vez que há um push na branch main.
Fluxo do Workflow

* **Checkout codebase**: Faz o checkout do código-fonte do projeto.
* **Install JDK 17**: Instala o JDK 17 usando a ação `actions/setup-java@v2`.
* **Cache Maven dependencies**: Armazena em cache as dependências do Maven para acelerar futuras execuções.
* **Build and Run unit tests**: Executa o build e os testes unitários com o Maven.
* **Set up for deploy to Sonatype**: Configura o ambiente para implantar no Sonatype Nexus, se o evento for um push na branch `develop` ou `main`.
* **Publish to Sonatype**: Publica o artefato no Sonatype Nexus, se o evento for um push na branch develop ou main.
* **Configure AWS**: Configura as credenciais da AWS, se o evento for um push na branch `develop` ou `main`.
* **Install Terraform**: Instala o Terraform.
* **Initialize Terraform**: Inicializa o Terraform na pasta `infra`.
* **Apply Terraform**: Aplica as mudanças do Terraform na AWS.
* **Package and Upload to S3**: Cria um pacote de implantação e o envia para o S3, se o evento for um push na branch `develop` ou `main`.
* **Deploy to AWS CodeDeploy**: Implanta o pacote de implantação no AWS CodeDeploy, se o evento for um push na branch `develop` ou `main`.
* **Deploy to AWS CodeDeploy EC2**: Implanta o pacote de implantação no AWS CodeDeploy para o EC2, se o evento for um push na branch `develop` ou `main`.

## Configuração

Antes de executar o fluxo de trabalho, certifique-se de configurar as seguintes variáveis secretas no seu repositório GitHub:

* `SONATYPE_USERNAME`: Nome de usuário do Sonatype Nexus.
* `SONATYPE_PASSWORD`: Senha do Sonatype Nexus.
* `CODESIGN_GPG_KEY`: Chave GPG privada para assinar artefatos.
* `CODESIGN_GPG_PASSPHRASE`: Senha da chave GPG.
* `AWS_ACCESS_KEY_ID`: ID da chave de acesso da AWS.
* `AWS_SECRET_ACCESS_KEY`: Chave de acesso secreta da AWS.
* `AWS_S3_BUCKET`: Nome do bucket do S3 onde o pacote de implantação será armazenado.

Além disso, substitua os valores de `YourApplicationName`, `YourDeploymentGroupName`, `YourEC2ApplicationName` e `YourEC2DeploymentGroupName` no arquivo `main.yml` pelos nomes reais do seu aplicativo e grupos de implantação no AWS CodeDeploy e no EC2.

## Uso

Faça um push na branch `main` para ativar o fluxo de trabalho do GitHub Actions. O fluxo de trabalho irá executar a integração contínua, realizando o build e os testes unitários. Se o evento for um push na branch `develop` ou `main`, o fluxo de trabalho também realizará a implantação contínua, publicando o artefato no Sonatype Nexus e implantando o pacote no AWS CodeDeploy e no EC2.


## Contribuição

Sinta-se à vontade para fazer um fork, modificar e contribuir para este projeto. Abra uma issue ou um pull request se desejar discutir melhorias ou correções de bugs