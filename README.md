# test_apt_repo

Test apt repo

```
docker run -it debian:stable /bin/bash
```

then:

```
apt update && apt install -y sudo wget gpg
```

Download the key:

```
wget -q -O - https://grzanka.github.io/test_apt_repo/public.gpg | sudo apt-key add -
```

Add the repo:

```
sudo wget -q -O /etc/apt/sources.list.d/datamedsci.list https://grzanka.github.io/test_apt_repo/datamedsci.list
```

Install the package:

```
apt update
apt install -y pymchelper
```

Test it:

```
runmc --version
```
