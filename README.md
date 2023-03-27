# Awscodepipe

Este projeto utiliza o GitHub Actions para realizar a Integração Contínua (CI) e Implantação Contínua (CD) de forma organizada e genérica. Os arquivos de configuração do fluxo de trabalho estão localizados na pasta .github/workflows. Os fluxos de trabalho são ativados toda vez que há um push na branch main.


## Estrutura do projeto

```bash
.
├── .github
│   └── workflows
│       ├── ci-build.yml
│       ├── setup-deploy.yml
│       ├── publish-sonatype.yml
│       ├── configure-aws.yml
│       ├── terraform.yml
│       ├── package-upload-s3.yml
│       ├── deploy-code-deploy.yml
│       └── deploy-code-deploy-ec2.yml
├── terraform
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── backend.tf
└── README.md
```

## Fluxo do Workflow

* **ci-build.yml**: Executa o build e os testes unitários com o Maven ou Gradle.
* **setup-deploy.yml**: Configura o ambiente para implantar no Sonatype Nexus, se o evento for um push na branch develop ou main.
* **publish-sonatype.yml**: Publica o artefato no Sonatype Nexus, se o evento for um push na branch develop ou main.
* **configure-aws.yml**: Configura as credenciais da AWS, se o evento for um push na branch develop ou main.
* **terraform.yml**: Inicializa e aplica as mudanças do Terraform na AWS.
* **package-upload-s3.yml**: Cria um pacote de implantação e o envia para o S3, se o evento for um push na branch develop ou main.
* **deploy-code-deploy.yml**: Implanta o pacote de implantação no AWS CodeDeploy, se o evento for um push na branch develop ou main.
* **deploy-code-deploy-ec2.yml**: Implanta o pacote de implantação no AWS CodeDeploy para o EC2, se o evento for um push na branch develop ou main.

Além disso há um **dependabot** que verifica se há atualizações para as dependências do projeto.

### Diagrama de fluxo

![Diagrama de fluxo](https://raw.githubusercontent.com/lobocode/awscodepipe/main/imgs/fluxUML.png)

## Configuração

Antes de executar o fluxo de trabalho, certifique-se de configurar as seguintes variáveis secretas no seu repositório GitHub:

* `SONATYPE_USERNAME`: Nome de usuário do Sonatype Nexus.
* `SONATYPE_PASSWORD`: Senha do Sonatype Nexus.
* `CODESIGN_GPG_KEY`: Chave GPG privada para assinar artefatos.
* `CODESIGN_GPG_PASSPHRASE`: Senha da chave GPG.
* `AWS_ACCESS_KEY_ID`: ID da chave de acesso da AWS.
* `AWS_SECRET_ACCESS_KEY`: Chave de acesso secreta da AWS.
* `AWS_S3_BUCKET`: Nome do bucket do S3 onde o pacote de implantação será armazenado.

Além disso, substitua os valores de `YourApplicationName`, `YourDeploymentGroupName`, `YourEC2ApplicationName` e `YourEC2DeploymentGroupName` no arquivo `main.yml` pelos nomes reais do seu aplicativo e grupos de implantação no AWS CodeDeploy e no EC2. Faça isso de forma segura via secrets do Github. Para tal, execute o seguinte passo-a-passo:

1. Vá até o menu Settings.
2. Clique em Secrets and Variables.
3. Clique em New repository secret e adicione as variáveis `AWS_CODEDEPLOY_APPLICATION_NAME`, `AWS_CODEDEPLOY_DEPLOYMENT_GROUP_NAME`, `AWS_CODEDEPLOY_EC2_APPLICATION_NAME` e `AWS_CODEDEPLOY_EC2_DEPLOYMENT_GROUP_NAME` e todos os seus respectivos valores em seguida (não esqueça de clicar em Add secret).

## Uso

Faça um push na branch `main` para ativar o fluxo de trabalho do GitHub Actions. O fluxo de trabalho irá executar a integração contínua, realizando o build e os testes unitários. Se o evento for um push na branch `develop` ou `main`, o fluxo de trabalho também realizará a implantação contínua, publicando o artefato no Sonatype Nexus e implantando o pacote no AWS CodeDeploy e no EC2.


## Contribuição

Sinta-se à vontade para fazer um fork, modificar e contribuir para este projeto. Abra uma issue ou um pull request se desejar discutir melhorias ou correções de bugs