#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Thu Mar 23 21:37:29 2023                
#                                                     
#######################################################

#@(#)CDS: Innovus v16.12-s051_1 (64bit) 08/17/2016 12:18 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 16.12-s051_1 NR160816-1350/16_12-UB (database version 2.30, 347.6.1) {superthreading v1.30}
#@(#)CDS: AAE 16.12-s026 (64bit) 08/17/2016 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 16.12-s023_1 () Aug 12 2016 01:35:46 ( )
#@(#)CDS: SYNTECH 16.12-s009_1 () Aug 11 2016 01:33:09 ( )
#@(#)CDS: CPE v16.12-s054
#@(#)CDS: IQRC/TQRC 15.2.4-s467 (64bit) Wed Jul 20 17:12:38 PDT 2016 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set delaycal_input_transition_delay 0.1ps
set distributed_client_message_echo 1
set distributed_mmmc_disable_reports_auto_redirection 0
set floorplan_default_site core
set fpIsMaxIoHeight 0
set init_gnd_net gnd
set init_io_file innovus.io
set init_lef_file {/package/eda/cells/OSU/v2.7/cadence/lib/ami05/lib/osu05_stdcells.lef /package/eda/cells/OSU/v2.7/cadence/lib/ami05/lib/osu05_stdcells.stacks.lef}
set init_mmmc_file osu05_MMMC.view
set init_oa_search_lib {}
set init_pwr_net vdd
set init_verilog mapped/layout_lab_design.v
set latch_time_borrow_mode max_borrow
set pegDefaultResScaleFactor 1
set pegDetailResScaleFactor 1
set report_inactive_arcs_format {from to when arc_type sense reason}
set timing_library_ccs_noise_vin_clip_points {}
set timing_library_ccs_noise_vout_clip_points {}
set timing_library_load_pin_cap_indices {}
set timing_library_write_library_to_directory {}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design
floorPlan -r 1.0 0.6 50 50 50 50
unfixAllIos
legalizePin
addRing -spacing_bottom 9.9 -width_left 9.9 -width_bottom 9.9 -width_top 9.9 -spacing_top 9.9 -layer_bottom metal1 -width_right 9.9 -around default_power_domain -center 1 -layer_top metal1 -spacing_right 9.9 -spacing_left 9.9 -layer_right metal2 -layer_left metal2 -offset 9.9 -nets { gnd vdd }
setPlaceMode -congEffort medium
placeDesign -inPlaceOpt
checkPlace
sroute
trialRoute
timeDesign -preCTS
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
optDesign -preCTS -drv
clockDesign
trialRoute
timeDesign -postCTS
setExtractRCMode -assumeMetFill
extractRC -outfile encounter.cap
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
optDesign -postCTS -hold
optDesign -postCTS -drv
all_hold_analysis_views
all_setup_analysis_views
getPlaceMode -doneQuickCTS -quiet
addFiller -cell FILL
setMetalFill -layer {1 2 3} -preferredDensity 35 -gapSpacing 0.2 -minWidth 0.1 -maxWidth 1.0 -minLength 0.1 -maxLength 10.0
globalNetConnect vdd -type tiehi
globalNetConnect vdd -type pgpin -pin vdd -all -override
globalNetConnect gnd -type tielo
globalNetConnect gnd -type pgpin -pin gnd -all -override
sroute
globalDetailRoute
setExtractRCMode -engine postRoute -effortLevel low -reduce 0.0
extractRC
setAnalysisMode -analysisType onChipVariation
setOptMode -yieldEffort none
setOptMode -effort high
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -simplifyNetlist false
setOptMode -usefulSkew false
optDesign -postRoute -incr
addFiller -cell FILL -prefix FIL -fillBoundary
ecoRoute
verifyConnectivity -type all -error 1000 -warning 50
verify_drc
streamOut final.gds2 -mapFile gds2_innovus.map -outputMacros -stripes 1 -units 1000 -mode ALL
saveNetlist -excludeLeafCell final.v
extractRC
rcOut -spf final.dspf
setDrawView ameba
setDrawView place
setDrawView fplan
setDrawView ameba
setDrawView place
setDrawView fplan
setDrawView ameba
setDrawView place
verifyConnectivity -type all -noWeakConnect -noUnroutedNet -connLoop -noSoftPGConnect -error 1000 -warning 50
verifyConnectivity -type all -geomLoop -noSoftPGConnect -error 1000 -warning 50
