# test_apt_repo

Test apt repo

```
docker run -it debian:stable /bin/bash
```

then:

```
apt update && apt install --yes sudo wget gpg
```

Download the key:

```
wget --quiet --output-document - https://grzanka.github.io/test_apt_repo/public.gpg | sudo apt-key add -
```

Add the repo:

```
sudo wget --quiet --output-document /etc/apt/sources.list.d/datamedsci.list https://grzanka.github.io/test_apt_repo/datamedsci.list
```

Install the package:

```
apt update
apt install --yes pymchelper-convertmc
apt install --yes pymchelper-runmc
```

or using metapackage:

```
apt update
apt install --yes pymchelper
```

Test it:

```
runmc --version
```
