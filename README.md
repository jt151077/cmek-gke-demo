![Component architecture](./infra.png)

* Source: https://cloud.google.com/architecture/deploying-highly-available-postgresql-with-gke
* Source: https://testdriven.io/blog/running-flask-on-kubernetes/



# Pre-Install

Make sure you have installed:
* Terraform
* Google Cloud SDK
* Create a username and password for PostgreSQL
```
:~$ echo "YOUR_PASSWORD" | base64
:~$ echo "YOUR_USERNAME" | base64
```
* Write the output values for each of these commands in `k8s/postgres-secrets.yaml`


# Install

At the root directory, install via terraform (inside script) with a user having the necessary permissions on the target project

```
:~$ ./script.sh
```

The first time around when you get the question whether the database is created, choose "NO"


With the `user` defined in `k8s/postgres-secrets.yaml`, run the following

```
:~$ POD=`kubectl get pods -l service=postgres -o wide | grep -v NAME | awk '{print $1}'`
:~$ kubectl exec -it $POD -- psql -U YOUR_USERNAME

:~$ create database flaskapi;
:~$ \q
```

Run the script one more time and choose "YES" this time when asked about the database creation.

```
:~$ ./script.sh
```

Create an entry in the Database:

```
:~$ curl -H "Content-Type: application/json" -d '{"name": "<NAME>", "email": "<EMAIL>", "pwd": "<PASSWORD>"}' http://<STATIC_IP>:5000/create
```




# Uninstall

With a user having the necessary permissions at the Google project level, run:
```
:~$ terraform destroy
```
