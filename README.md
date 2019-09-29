# chromium-ci

> Don't trust random people on the internet telling you to disable the [sandbox](https://web.dev/browser-sandbox)!

chromium-ci allows you to execute tests (e.g., using Karma) against a dockerized headless Chrome (Chromium) without disabling the sandbox. 

## Sample usage

```sh
docker run
    --security-opt seccomp=seccomp/chromium.json
    -v `pwd`/node-ci-demo:/app
    tkp1n/chromium
    npm run ci-test
```

The required seccomp config file is available in [this repo](https://github.com/tkp1n/chromium-ci/blob/master/seccomp/chromium.json) and is based on the default config found [here](https://raw.githubusercontent.com/moby/moby/master/profiles/seccomp/default.json), extended with the required syscalls made by Chromium as reported [here](https://github.com/docker/for-linux/issues/496#issuecomment-441149510).

## Testing an Angular app

You can test the barebones Angular app in this repo without any changes to the configuration of the project by running the following command inside `tkp1n/chromium`:

* `npm run test -- --browsers=ChromeHeadless --no-watch`

### Pro tip

If your application uses a lot of memory, the 64MB of shared memory with which Docker runs the container might not be enough. Run Chromium with the following parameter, to work around this issue:

* `--disable-dev-shm-usage`