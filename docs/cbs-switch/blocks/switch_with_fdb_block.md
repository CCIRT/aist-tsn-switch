# Switch with FDB block

![switch_with_fdb_block_overview](./switch_with_fdb_block_overview.drawio.svg)

- This block provides Ethernet frame switching based on Destination MAC Address
  - When Destination MAC Address is already registered in FDB, output the Ethernet frame only to the registered port
  - When not, output the Ethernet frame to all ports except the received port
- This block has independent 4x4 switch for each priority to prevent interference between Ethernet frames of different priorities
- The output is also wired independently for each priority to prevent interference between Ethernet frames of different priorities

## FDB block

- This block provides 'Filtering DataBase' function
  - The FDB function is realized by the following operation
- Register Source MAC Address
  - Register the Source MAC Address of the received Ethernet frame to the Database by linking it with the received port
- Search Destination MAC Address
  - Query the Destination MAC Address of the received Ethernet frame to the Database
    - When registered in Database, destination port is decided to the linked port
    - When not, in order to sent to all ports except the received port, copy the Ethernet frame into three parts and send them to different ports
- Note: this block just decides destination port and does not switch Ethernet frame

## Priority Switcher block

- This block switches Ethernet frame according to Priority
- The destination port information which is given in FDB block passes through this block

## 4x4 switch based on FDB result block

- This block switches Ethernet frame based on the destination port information which is given in FDB block
  - This block exists 8 for each Priority
- The priority is same for each input port, it works with round-robin algorithm
  - However, once this block starts passing the Ethernet frame from a certain input, it will continue passing until the end of the Ethernet frame
