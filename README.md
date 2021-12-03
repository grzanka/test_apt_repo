# test_apt_repo

Test apt repo

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
apt install pymchelper

```

Test it:

```
pld2sobp --version
```
