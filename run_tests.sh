#!/bin/bash

# possible flag passed in
typeOfTesting=$1

echo "Rtest Begin: " $typeOfTesting

NaluRtestCWD=$(pwd)

cd ..
baseGitHubCWD=$(pwd)

# create the directory in which the tests will be run (if it does not exist)
if [ ! -d "$baseGitHubCWD/runNaluRtest" ]; then
    mkdir $baseGitHubCWD/runNaluRtest
    mkdir $baseGitHubCWD/runNaluRtest/nightly
    mkdir $baseGitHubCWD/runNaluRtest/performance
fi

# look for file that defines the path to naluX
if [ ! -f $NaluRtestCWD/NaluProjectPath.txt ]; then
    # copy executable for all tests to use
    if [ "$typeOfTesting" == "DEBUG" ]; then
        cp $baseGitHubCWD/Nalu/build/naluXd $baseGitHubCWD/runNaluRtest/naluX
    else
        cp $baseGitHubCWD/Nalu/build/naluX $baseGitHubCWD/runNaluRtest/naluX
    fi
else
    NaluProjectPathFile="$NaluRtestCWD/NaluProjectPath.txt"
    projectPathName=$(cat $NaluProjectPathFile)
    if [ "$typeOfTesting" == "DEBUG" ]; then
        cp $projectPathName/build/naluXd $baseGitHubCWD/runNaluRtest/naluX
    else
        cp $projectPathName/build/naluX $baseGitHubCWD/runNaluRtest/naluX
    fi
fi

# copy pass_fail script
cp $NaluRtestCWD/pass_fail.sh $baseGitHubCWD/runNaluRtest

#=============================================================================
# dgNonConformal test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformal" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/*.g* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
# run it...  
./dgNonConformal.sh
# report it; 30 spaces
passStatusDgNonConformal="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal/dgNonConformal.log  | awk '{print $4}'`
if [ $passStatusDgNonConformal -ne 1 ]; then
    echo -e "..dgNonConformal.............. FAILED":" " $GlobalPerformanceTime " s" 
else
    echo -e "..dgNonConformal.............. PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# concentricRad test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/concentricRad" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/concentricRad
fi

cd $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.i $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/*.g.* $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.sh $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.norm.gold $baseGitHubCWD/runNaluRtest/nightly/concentricRad
# run it...  
./concentricRad.sh
# report it; 30 spaces
passStatusConcentricRad="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/concentricRad/concentricRad.log  | awk '{print $4}'`
if [ $passStatusConcentricRad -ne 1 ]; then
    echo -e "..concentricRad............... FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..concentricRad............... PASSED":" " $GlobalPerformanceTime " s" 
fi

#=============================================================================
# movingCylinder test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/movingCylinder" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
fi

cd $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.i $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/*.g.* $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.sh $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.norm.gold $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
# run it...  
./movingCylinder.sh
# report it; 30 spaces
passStatusMovingCylinder="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/movingCylinder/movingCylinder.log  | awk '{print $4}'`
if [ $passStatusMovingCylinder -ne 1 ]; then
    echo -e "..movingCylinder.............. FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..movingCylinder.............. PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# elemBackStepLRSST test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.i $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/*.g.* $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.sh $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
# run it...  
./elemBackStepLRSST.sh
# report it; 30 spaces
passStatusElemBackStep="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST/elemBackStepLRSST.log  | awk '{print $4}'`
if [ $passStatusElemBackStep -ne 1 ]; then
    echo -e "..elemBackStepLRSST........... FAILED":" " $GlobalPerformanceTime " s"

else
    echo -e "..elemBackStepLRSST........... PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# edgePipeCHT test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.i $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/*.g.* $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.sh $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
# run it...  
./edgePipeCHT.sh
# report it; 30 spaces
passStatusEdgePipeCHT="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT/edgePipeCHT.log  | awk '{print $4}'`
if [ $passStatusEdgePipeCHT -ne 1 ]; then
    echo -e "..edgePipeCHT................. FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..edgePipeCHT................. PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# heliumPlumeEdge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.i $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/*.g.* $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.sh $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
# run it...  
./heliumPlumeEdge.sh
# report it; 30 spaces
passStatusHeliumPlume="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge/heliumPlumeEdge.log  | awk '{print $4}'`
if [ $passStatusHeliumPlume -ne 1 ]; then
    echo -e "..heliumPlumeEdge............. FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..heliumPlumeEdge............. PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# edgeContact3D test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgeContact3D" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.i $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/*.xml $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/*.exo.* $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.sh $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
# run it...  
./edgeContact3D.sh
# report it; 30 spaces
passStatusEdgeContact="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D/edgeContact3D.log  | awk '{print $4}'`
if [ $passStatusEdgeContact -ne 1 ]; then
    echo -e "..edgeContact3D............... FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..edgeContact3D............... PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# fluidsPmrChtPeriodic test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
fi

cd $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.i $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/*.g.* $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.sh $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.norm.gold $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
# run it...  
./fluidsPmrChtPeriodic.sh
# report it; 30 spaces
passStatusFluidsPmrCht="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.log  | awk '{print $4}'`
if [ $passStatusFluidsPmrCht -ne 1 ]; then
    echo -e "..fluidsPmrChtPeriodic........ FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..fluidsPmrChtPeriodic........ PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# nonIsoElemOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
# run it...  
./nonIsoElemOpenJet.sh
# report it; 30 spaces
passStatusNonIsoElemOpenJet="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.log  | awk '{print $4}'`
if [ $passStatusNonIsoElemOpenJet -ne 1 ]; then
    echo -e "..nonIsoElemOpenJet........... FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..nonIsoElemOpenJet........... PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# nonIsoEdgeOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
# run it...  
./nonIsoEdgeOpenJet.sh
# report it; 30 spaces
passStatusNonIsoEdgeOpenJet="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.log  | awk '{print $4}'`
if [ $passStatusNonIsoEdgeOpenJet -ne 1 ]; then
    echo -e "..nonIsoEdgeOpenJet........... FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..nonIsoEdgeOpenJet........... PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# elemHybridFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.i $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/mesh/hybrid.g* $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.sh $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
# run it...  
./elemHybridFluids.sh
# report it; 30 spaces
passStatusElemHybrid="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids/elemHybridFluids.log  | awk '{print $4}'`
if [ $passStatusElemHybrid -ne 1 ]; then
    echo -e "..elemHybridFluids............ FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..elemHybridFluids............ PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# edgeHybridFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.i $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/mesh/hybrid.g* $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.sh $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
# run it...  
./edgeHybridFluids.sh
# report it; 30 spaces
passStatusEdgeHybrid="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids/edgeHybridFluids.log  | awk '{print $4}'`
if [ $passStatusEdgeHybrid -ne 1 ]; then
    echo -e "..edgeHybridFluids............ FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..edgeHybridFluids............ PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# elemClosedDomain test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.i $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/*.g.* $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.sh $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
# run it...  
./elemClosedDomain.sh
# report it; 30 spaces
passStatusElemClosed="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain/elemClosedDomain.log  | awk '{print $4}'`
if [ $passStatusElemClosed -ne 1 ]; then
    echo -e "..elemClosedDomain............ FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..elemClosedDomain............ PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# mixedTetPipe test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
fi

cd $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.i $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/mesh/pipeTet.g* $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.sh $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.norm.gold $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
# run it...  
./mixedTetPipe.sh
# report it; 30 spaces
passStatusMixedTet="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe/mixedTetPipe.log  | awk '{print $4}'`
if [ $passStatusMixedTet -ne 1 ]; then
    echo -e "..mixedTetPipe................ FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..mixedTetPipe................ PASSED":" " $GlobalPerformanceTime " s"
fi

echo "Rtest End"
