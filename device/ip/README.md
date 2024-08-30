# ip

This directory contains IP for ATS and CBS.

## Directories

```
├── ats : IP for ATS
└── cbs : IP for CBS
```

## Files

- [README.md](./README.md): This file

## How to package IP

### Create new IP

1. Create a directory and place a RTL file that you want to convert to IP under the [rtl](../rtl) directory
2. Create a directory and a symbolic link under the [ip](./) directory
3. Open Vivado
4. Click "Tools" - "Create and Package New IP"
5. Click "Next"
6. Select "Package a specified directory" and click "Next"
7. Select the directory of symbolic link and click "Next"
8. Continue clicking "Next" until "Finish"
9. Check the contents of the generated IP
10. Click "Review and Package" - "Re-Package IP"

### Update existing IP

- After editing RTL file, there is no need to update IP when that interface and parameters are not changed
- When changed, do step 3 and later of [Create new IP](#create-new-ip)
