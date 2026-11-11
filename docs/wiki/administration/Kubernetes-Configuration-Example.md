# Kubernetes configuration example

## Helm chart

A community chart: https://github.com/kokuwaio/helm-charts/tree/main/charts/visual-regression-tracker

## Manual setup

Notes for VRT 6.0:

- `JWT_SECRET` is required. Use a random value, for example `openssl rand -hex 32`.
- The api and migration images run as user id 1000. Set `securityContext.fsGroup: 1000` for volumes.
- Run the migration job to completion before the api starts.
- Use the same version for api, migration and UI.
- Auto approve is a project setting. `AUTO_APPROVE_BASED_ON_HISTORY` is not used.
- With more than one api replica, set `REDIS_URL`. See [Configuration](Configuration).
- The database must be PostgreSQL 12 or later. 15 or later is recommended.

The example below has one backend pod and one frontend pod in the `default` namespace.

- Both Services are `type: LoadBalancer`, so they need a cloud or a load balancer provider.
  See the [Kubernetes docs](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/).
- Put their addresses in `APP_FRONTEND_URL` and `REACT_APP_API_URL`. DNS names are better than IPs.

## Backend resources
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vrt-backend
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vrt-backend
  template:
    metadata:
      labels:
        app: vrt-backend
      name: vrt-backend
    spec:
      containers:
      - name: api
        image: visualregressiontracker/api:6.0.0
        env:
        - name: APP_FRONTEND_URL
          value: <APP_FRONTEND_URL>
        - name: APP_PORT
          value: "4200"
        - name: DATABASE_URL
          value: <DATABASE_URL>
        - name: BODY_PARSER_JSON_LIMIT
          value: "5mb"
        - name: JWT_LIFE_TIME
          value: "1d"
        - name: JWT_SECRET
          value: <PLACEHOLDER>
        ports:
        - containerPort: 4200
          name: http
```
```yaml
apiVersion: v1
kind: Service
metadata:
  name: vrt-backend
  namespace: default
spec:
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 4200
  selector:
    app: vrt-backend
  type: LoadBalancer
```
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: migration
  namespace: default
spec:
  template:
    spec:
      containers:
      - name: migration
        image: visualregressiontracker/migration:6.0.0
        env:
        - name: DATABASE_URL
          value: <DATABASE_URL>
      restartPolicy: Never
```

## Frontend resources
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vrt-frontend
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vrt-frontend
  template:
    metadata:
      labels:
        app: vrt-frontend
      name: vrt-frontend
    spec:
      containers:
      - name: vrt-frontend
        image: visualregressiontracker/ui:6.0.0
        env:
        - name: REACT_APP_API_URL
          value: <REACT_APP_API_URL>
        ports:
        - containerPort: 8080
          name: http
```
```yaml
apiVersion: v1
kind: Service
metadata:
  name: vrt-frontend
  namespace: default
spec:
  ports:
    - name: ui
      port: 80
      targetPort: 8080
  selector:
    app: vrt-frontend
  type: LoadBalancer
```
