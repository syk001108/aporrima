
#!/bin/bash

./aporrima/hadoop/install.sh
./aporrima/hadoop/hostset.sh $@
./aporrima/hadoop/makeUser.sh
