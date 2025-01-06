//
// Vivado(TM)
// rundef.js: a Vivado-generated Runs Script for WSH 5.1/5.6
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//

echo "This script was generated under a different operating system."
echo "Please update the PATH variable below, before executing this script"
exit

var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
  PathVal = "/mnt/24e10873-2673-45cb-9c25-1e82b2a26751/Vivado_Files/Vitis/2024.2/bin:/mnt/24e10873-2673-45cb-9c25-1e82b2a26751/Vivado_Files/Vivado/2024.2/ids_lite/ISE/bin/lin64;/mnt/24e10873-2673-45cb-9c25-1e82b2a26751/Vivado_Files/Vivado/2024.2/bin;";
} else {
  PathVal = "/mnt/24e10873-2673-45cb-9c25-1e82b2a26751/Vivado_Files/Vitis/2024.2/bin:/mnt/24e10873-2673-45cb-9c25-1e82b2a26751/Vivado_Files/Vivado/2024.2/ids_lite/ISE/bin/lin64;/mnt/24e10873-2673-45cb-9c25-1e82b2a26751/Vivado_Files/Vivado/2024.2/bin;" + PathVal;
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


// pre-commands:
ISETouchFile( "write_bitstream", "begin" );
ISEStep( "vivado",
         "-log slowrunninglights.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source slowrunninglights.tcl -notrace" );





function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}
