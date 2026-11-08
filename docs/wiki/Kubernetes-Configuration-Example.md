# Helm chart 
External repository with example

https://github.com/kokuwaio/helm-charts/tree/main/charts/visual-regression-tracker


# Manual setup

Notes for VRT 6.0:

- `JWT_SECRET` is required: the API does not start without it or with the old sample value. Use a random value, for example from `openssl rand -hex 32`.
- The api and migration images run as user id 1000, not root. If you mount volumes or TLS files, make them readable and writable for that user (for example with `securityContext.fsGroup: 1000`).
- Run the migration job to completion before the api starts, and use the same version for api, migration and UI.
- Auto approve is a project setting now; the `AUTO_APPROVE_BASED_ON_HISTORY` variable is no longer used.
- Live updates need a login token. With more than one API replica set `REDIS_URL`. See [Configuration](Configuration).
- The database must be PostgreSQL 12 or later; 15 or later is recommended.

The following example consists of a single backend pod and a single frontend pod, both running in the `default` namespace. Each of the Services have been configured as `type: LoadBalancer`. This means that external load balancers will be created for both of these services, so that they will be accessible from outside the cluster. As described [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/), `This feature is only available for cloud providers or environments which support external load balancers`. The IP addresses that get exposed can be given for the `APP_FRONTEND_URL` and `REACT_APP_API_URL` environment variables, but ideally you would set up DNS records for those IPs and use those instead.

# Backend resources
```
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
        - containerPort: "4200"
          name: http
```
```
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
```
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

# Frontend resources
```
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
```
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