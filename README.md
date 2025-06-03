# Suricata Note

The most recommended way to fetch and update [Suricata signatures](https://docs.suricata.io/en/suricata-7.0.10/quickstart.html#signatures) is using the `suricata-update` tool, which is an official Suricata tool. This tool manages the ruleset by downloading, updating, and installing them into the specified location, typically `/var/lib/suricata/rules`. To install suricata from source, please refer [installation](https://docs.suricata.io/en/latest/install.html).

## Attention
The execution of jasonish/suricata has no gurantee of success on first run, due:
- connection via suricata site, since it will fetch the latest rules directly from the site

So the retry should be made, for example, in Jenkins or other tool.


### To avoid some known issues
Synchronize the rules sources first:

```
> suricata-update update-sources
```

Without reload suricate after rules fetch:
```
> suricata-update --no-reload
```
due to race condition inside container, may missing `/var/run/suricata/suricata-command.socket`.

## Disable Drop rules configuration

### References
- [config](https://suricata-update.readthedocs.io/en/latest/update.html)
- [keywords](https://docs.suricata.io/en/latest/rules/meta.html#metadata)
- [A solution with flowbit](https://forum.suricata.io/t/write-suricata-rules-trigger-condition-to-both-http-request-and-http-response/3719/2)