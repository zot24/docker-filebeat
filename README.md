[![](https://badge.imagelayers.io/zot24/filebeat:latest.svg)](https://imagelayers.io/?images=zot24/filebeat:latest 'Get your own badge on imagelayers.io')

# Filebeat Docker image

This is a Filebeat docker base image using [Alpine](http://alpinelinux.org/) Linux [modify version](https://hub.docker.com/r/zot24/glibc/) to support `glibc` used by `filebeat` and based on the [primait/docker-filebeat](https://github.com/primait/docker-filebeat) docker image with just few modifications to make it even more basic, actually it won't be useful unless you set it as a base image and extend it using the `FROM` instruction.

## Getting Started

This container have been build for being used as a base image and extend it, so you'll need to first to `COPY/ADD` your configuration file `filebeat.yml` when extending the base image and mount the shared volume that will contain your `log` files, like:

Imaging we got an `filebeat.yml` like this one:

```
filebeat:
  prospectors:
    -
      paths:
        - /var/log/nginx/myapp/access.log
      input_type: log
      scan_frequency: 5s
```

```
FROM zot24/filebeat

COPY ./config/filebeat/ /etc/filebeat/
VOLUME /var/log

CMD [ "filebeat", "-c", "/etc/filebeat/filebeat.yml"] # by default it will load the config file from this path
```

So our `nginx` container will be writing log file into our shrared volume `/var/log/nginx/myapp` that way `filebeat` will have access to the log files.

> *Notice:* You'll need to point out where the `filebeat.yml` file is to be loaded by `filebeat`, by default it will look in the same path than this example
`/etc/filebeat/filebeat.yml` (so techinically there is no need to add that last line) but you can use whatever path you like most to store your config files

## Resources

Some util resources about filebeat + docker + images + alpine + being smart :)

* [Elastic - Filebeat - Documentation](https://www.elastic.co/guide/en/beats/filebeat/1.1/configuration-filebeat-options.html)
* [Tips & Tricks with Alpine + Docker](http://blog.zot24.com/tips-tricks-with-alpine-docker/)
* [Tips & Tricks with Docker & Docker compose](http://blog.zot24.com/tips-tricks-docker/)

## Authors

* **Israel Sotomayor** - *Initial work* - [zot24](https://github.com/zot24)

See also the list of [contributors](https://github.com/zot24/docker-filebeat/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/zot24/docker-filebeat/blob/master/LICENSE) file for details
