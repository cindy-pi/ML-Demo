
This is how to run playbooks

You will need to install python3 (Ref: https://www.python.org/downloads/ )
Once python3 is install you can verify with following command

```
 > python3 --version
Python 3.9.6

```

Next you need to install pip (Ref: https://pip.pypa.io/en/stable/installation/ )
Once pip is installed you can verify with the following command

```
 > python3 -m pip -V
pip 22.1.2 from /usr/local/lib/python3.9/site-packages/pip (python 3.9)

```

Now you can install ansible (Ref: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html )
Once ansible is installed you can verify with the following command

```
 > ansible --version
ansible [core 2.13.4]
```

run
```
./ping-all.sh
ansible-playbook playbooks/globals.yaml
```






