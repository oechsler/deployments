#!/bin/bash

cp ${ECO_SERVER_FILES}/ConfigTemplates/*.template ${ECO_SERVER_FILES}/Configs

# Start server
cd ${ECO_SERVER_FILES}
./EcoServer -nogui