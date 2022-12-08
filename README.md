# debian-asdf-terraform

[![GitHub](https://img.shields.io/github/v/tag/caspiandb/docker-debian-asdf-terraform?label=GitHub)](https://github.com/caspiandb/docker-debian-asdf-terraform)
[![CI](https://github.com/caspiandb/docker-debian-asdf-terraform/actions/workflows/ci.yaml/badge.svg)](https://github.com/caspiandb/docker-debian-asdf-terraform/actions/workflows/ci.yaml)
[![Trunk Check](https://github.com/caspiandb/docker-debian-asdf-terraform/actions/workflows/trunk.yaml/badge.svg)](https://github.com/caspiandb/docker-debian-asdf-terraform/actions/workflows/trunk.yaml)
[![Docker Image Version](https://img.shields.io/docker/v/caspiandb/debian-asdf-terraform/latest?label=docker&logo=docker)](https://hub.docker.com/r/caspiandb/debian-asdf-terraform)

Container image with:

- [aws-cli](https://github.com/aws/aws-cli)
- [Infracost](https://github.com/infracost/infracost)
- [Terraform](https://github.com/hashicorp/terraform)

Additional Debian packages:

- [bzip2](https://packages.debian.org/bullseye/bzip2)
- [git-lfs](https://packages.debian.org/bullseye/git-lfs)
- [gnupg](https://packages.debian.org/bullseye/gnupg)
- [groff-base](https://packages.debian.org/bullseye/groff-base)
- [openssh-client](https://packages.debian.org/bullseye/openssh-client)
- [procps](https://packages.debian.org/bullseye/procps)
- [pv](https://packages.debian.org/bullseye/pv)
- [xz-utils](https://packages.debian.org/bullseye/xz-utils)

Additional tools:

- [tf](https://github.com/dex4er/tf)

## Tags

- `terraform-X.Y.Z-awscli-X.Y.Z-infracost-X.Y.Z-asdf-X.Y.Z-bullseye-YYYYmmdd`, `terraform-X.Y.Z`, `latest`

## Usage

CLI:

```shell
docker pull caspiandb/debian-asdf-terraform
docker run -v ~/.aws:/root/.aws -e AWS_PROFILE caspiandb/debian-asdf-terraform aws sts get-caller-identity
```

Dockerfile:

```Dockerfile
FROM caspiandb/debian-asdf-terraform:latest
RUN aws --version
RUN infracost --version
RUN terraform --version
```

## License

[License information](https://github.com/asdf-vm/asdf/blob/master/LICENSE) for
[asdf](https://asdf-vm.com/) project.

[License information](https://github.com/aws/aws-cli/blob/develop/LICENSE.txt)
for [aws-cli](https://github.com/aws/aws-cli) project.

[License
information](https://github.com/infracost/infracost/blob/master/LICENSE) for
[Infracost](https://github.com/infracost/infracost) project.

[License
information](https://github.com/hashicorp/terraform/blob/main/LICENSE) for
[Terraform](https://github.com/hashicorp/terraform) project.

[License
information](https://github.com/dex4er/tf/blob/main/LICENSE) for
[tf](https://github.com/dex4er/tf) project.

[License
information](https://github.com/caspiandb/docker-debian-asdf-terraform/blob/main/LICENSE) for
container image project.
