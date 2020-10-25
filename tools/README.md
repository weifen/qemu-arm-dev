
## mygrep.py

You may want to browse all the device models in qemu/hw/\*/\*.c to know what is the standard way to model a device in QEMU. In each file, there is a common function with XXXX_class_init() as its name. In addition, each file also has a TypeInfo struct definition. Below is an example. 
```cpp=
    static void sbsa_ec_class_init(ObjectClass *klass, void *data)
    {
    DeviceClass *dc = DEVICE_CLASS(klass);

    /* No vmstate or reset required: device has no internal state */
    dc->user_creatable = false;
    }

    static const TypeInfo sbsa_ec_info = {
    .name          = TYPE_SBSA_EC,
    .parent        = TYPE_SYS_BUS_DEVICE,
    .instance_size = sizeof(SECUREECState),
    .instance_init = sbsa_ec_init,
    .class_init    = sbsa_ec_class_init,
    };
```
    You may need to check whether all devices are derived from the DEVICE_CLASS. and what its parent type is. To browse all files to get the information, a `mygrep.py` script is provided to facilitate the process.  
    
### Solution Proposal
In linux prompt, you may use the command, **'grep'**, to grep the line that contains a particular string in all files. For example, you can type:
```shell=
$ grep class_init qemu/hw/\*/\*.c
```
However, it cannot grep a whole function or TypeInfo struct easily. 

Here is a tool to do that. 
 
```shell=
$ mypython.py <search dict> <filename/files in regexp>

## where
## <serarch dict> is a JSON string that describes the searched items. Here is an example:
## '{"static const TypeInfo":"f", "class_init":"f", "type_init": "sl"}'
## Each key is a searched string
## Value can be 'f' for code block with '{}' or 'sl' for single string

## e.g. 
$ ./mygrep.py '{"static const TypeInfo":"f", "class_init":"f", "type_init": "sl"}' "source/hw/misc/*c"

```

