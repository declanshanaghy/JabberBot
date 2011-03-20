//POVRay-File created by 3d41.ulp v20110101
///Users/dshanaghy/Workspace/PersonalProjects/PhonicBot/Hardware/MasterBoard.brd
//3/18/11 8:50 AM

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = 262;
#local cam_z = -140;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -6;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 22;
#local lgt1_pos_y = 34;
#local lgt1_pos_z = 32;
#local lgt1_intense = 0.750912;
#local lgt2_pos_x = -22;
#local lgt2_pos_y = 34;
#local lgt2_pos_z = 32;
#local lgt2_intense = 0.750912;
#local lgt3_pos_x = 22;
#local lgt3_pos_y = 34;
#local lgt3_pos_z = -21;
#local lgt3_intense = 0.750912;
#local lgt4_pos_x = -22;
#local lgt4_pos_y = 34;
#local lgt4_pos_z = -21;
#local lgt4_intense = 0.750912;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 58.471000;
#declare pcb_y_size = 60.950000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(861);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-29.235500,0,-30.475000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro MASTERBOARD(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<0.000000,0.000000><58.471000,0.000000>
<58.471000,0.000000><58.471000,60.950000>
<58.471000,60.950000><0.000000,60.950000>
<0.000000,60.950000><0.000000,0.000000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
cylinder{<54.610000,1,3.810000><54.610000,-5,3.810000>1.651000 texture{col_hls}}
cylinder{<54.610000,1,57.150000><54.610000,-5,57.150000>1.651000 texture{col_hls}}
cylinder{<3.810000,1,3.810000><3.810000,-5,3.810000>1.651000 texture{col_hls}}
cylinder{<3.810000,1,57.150000><3.810000,-5,57.150000>1.651000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {TR_TO220_3_V("LM7805",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<26.670000,0.000000,57.150000>}#end		//TO220 vertical straight leads IC1 LM7805 TO220V
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {IC_DIS_DIP28("AT90S4433P","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<34.290000,0.000000,17.780000>translate<0,3.000000,0> }#end		//DIP28 300mil IC3 AT90S4433P DIL28-3
#ifndef(pack_IC3) object{SOCKET_DIP28()rotate<0,0.000000,0> rotate<0,0,0> translate<34.290000,0.000000,17.780000>}#end					//IC-Sockel 28Pin IC3 AT90S4433P
#ifndef(pack_IC4) #declare global_pack_IC4=yes; object {IC_DIS_DIP8("TL072P","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<17.780000,0.000000,29.210000>translate<0,3.000000,0> }#end		//DIP8 IC4 TL072P DIL08
#ifndef(pack_IC4) object{SOCKET_DIP8()rotate<0,0.000000,0> rotate<0,0,0> translate<17.780000,0.000000,29.210000>}#end					//IC-Sockel 8Pin IC4 TL072P
#ifndef(pack_JP3) #declare global_pack_JP3=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<2.540000,0.000000,49.530000>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) JP3 PWR_SW 1X02
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_3MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<8.890000,0.000000,46.990000>}#end		//Diskrete 3MM LED LED1 PWR_LED LED3MM
#ifndef(pack_S1) #declare global_pack_S1=yes; object {SWITCH_B3F_10XX1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<6.350000,0.000000,11.430000>}#end		//Tactile Switch-Omron S1 RESET B3F-10XX
#ifndef(pack_U_1) #declare global_pack_U_1=yes; object {IC_DIS_DIP20("DS1802PB","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<39.370000,0.000000,30.480000>translate<0,3.000000,0> }#end		//DIP20 U$1 DS1802PB DIL20
#ifndef(pack_U_1) object{SOCKET_DIP20()rotate<0,0.000000,0> rotate<0,0,0> translate<39.370000,0.000000,30.480000>}#end					//IC-Sockel 20Pin U$1 DS1802PB
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_BTM8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<2.540000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_BTM8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<2.540000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_BTM8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<2.540000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_BTM8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<2.540000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_BTM8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<2.540000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_BTM8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<2.540000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_BTM8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<2.540000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<15.240000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<17.780000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<50.800000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<50.800000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<49.530000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<52.070000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<53.340000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<55.880000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<44.450000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<46.990000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<36.830000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<34.290000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<10.160000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<12.700000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<10.160000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<10.160000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<13.970000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<13.970000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<15.240000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<7.620000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_I2C_A) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_I2C_A) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<37.084000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_I2C_A) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_I2C_A) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<37.084000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_I2C_A) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_I2C_A) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<37.084000,0,52.070000> texture{col_thl}}
#ifndef(global_pack_I2C_B) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_I2C_B) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.434000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_I2C_B) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_I2C_B) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.434000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_I2C_B) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_I2C_B) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.434000,0,52.070000> texture{col_thl}}
#ifndef(global_pack_I2C_C) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<49.530000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_I2C_C) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<49.784000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_I2C_C) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<49.530000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_I2C_C) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<49.784000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_I2C_C) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<49.530000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_I2C_C) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<49.784000,0,52.070000> texture{col_thl}}
#ifndef(global_pack_I2C_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<55.880000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_I2C_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<56.134000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_I2C_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<55.880000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_I2C_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<56.134000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_I2C_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<55.880000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_I2C_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<56.134000,0,52.070000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<24.130000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<26.670000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<29.210000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,54.991000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,59.309000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<13.970000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<16.510000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<19.050000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<21.590000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<21.590000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<19.050000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<16.510000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<13.970000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<17.907000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<15.113000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<11.557000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<8.763000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<2.540000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<2.540000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<19.050000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<8.890000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<21.590000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<11.430000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<13.970000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<16.510000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,0+global_tmp,0) rotate<0,-90.000000,0>translate<3.810000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<3.810000,0,38.354000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,2.667000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.940000,0,2.413000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<30.480000,0,2.667000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<33.020000,0,2.413000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<35.560000,0,2.667000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<38.100000,0,2.413000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<40.640000,0,2.667000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,2.413000> texture{col_thl}}
#ifndef(global_pack_JP10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<45.720000,0,2.667000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,5.207000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.940000,0,4.953000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<30.480000,0,5.207000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<33.020000,0,4.953000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<35.560000,0,5.207000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<38.100000,0,4.953000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<40.640000,0,5.207000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,4.953000> texture{col_thl}}
#ifndef(global_pack_JP11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<45.720000,0,5.207000> texture{col_thl}}
#ifndef(global_pack_JP12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<35.560000,0,7.747000> texture{col_thl}}
#ifndef(global_pack_JP12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<38.100000,0,7.493000> texture{col_thl}}
#ifndef(global_pack_JP12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<40.640000,0,7.747000> texture{col_thl}}
#ifndef(global_pack_JP12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,7.493000> texture{col_thl}}
#ifndef(global_pack_JP12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<45.720000,0,7.747000> texture{col_thl}}
#ifndef(global_pack_JP13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<49.403000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_JP13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<49.657000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_JP13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<49.403000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_JP15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<33.020000,0,7.493000> texture{col_thl}}
#ifndef(global_pack_JP15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.480000,0,7.747000> texture{col_thl}}
#ifndef(global_pack_JP15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<27.940000,0,7.493000> texture{col_thl}}
#ifndef(global_pack_JP15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<25.400000,0,7.747000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<8.890000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<8.890000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<2.540000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<20.320000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<16.510000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<3.098800,0,13.690600> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<9.601200,0,13.690600> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<3.098800,0,9.169400> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<9.601200,0,9.169400> texture{col_thl}}
#ifndef(global_pack_SUP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<57.023000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SUP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<57.277000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SUP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<57.023000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_SUP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<57.277000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_Y1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<55.880000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_Y1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<55.880000,0,19.050000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<30.480000,0,17.678400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<27.838400,0,16.256000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<25.400000,0,16.256000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<38.201600,0,16.256000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<35.356800,0,9.956800> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<6.502400,0,14.020800> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<52.628800,0,26.822400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<53.238400,0,29.870400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<35.102800,0,29.667200> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<27.051000,0,29.718000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<30.226000,0,29.718000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<33.121600,0,18.694400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<43.484800,0,18.694400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<7.721600,0,19.710400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<30.632400,0,38.049200> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<41.046400,0,56.692800> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<42.672000,0,58.318400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.508000,1,16,1,0) translate<52.628800,0,15.443200> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.406400,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.406400,-1.535000,27.228800>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,90.000000,0> translate<0.406400,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.406400,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.438400,-1.535000,19.100800>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,44.997030,0> translate<0.406400,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.406400,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.438400,-1.535000,29.260800>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,-44.997030,0> translate<0.406400,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.438400,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.540000,-1.535000,19.050000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,26.563298,0> translate<2.438400,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.438400,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.540000,-1.535000,29.210000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,26.563298,0> translate<2.438400,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.540000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,0.000000,16.662400>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,-56.306216,0> translate<2.540000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.540000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,-1.535000,21.539200>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,26.563298,0> translate<2.540000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.540000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,-1.535000,23.977600>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,56.306216,0> translate<2.540000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.540000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,-1.535000,49.580800>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,-26.563298,0> translate<2.540000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,-1.535000,49.580800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,-1.535000,50.800000>}
box{<0,0,-0.152400><1.219200,0.035000,0.152400> rotate<0,90.000000,0> translate<2.641600,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.098800,-1.535000,13.690600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.251200,-1.535000,13.614400>}
box{<0,0,-0.152400><0.170388,0.035000,0.152400> rotate<0,26.563298,0> translate<3.098800,-1.535000,13.690600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.251200,0.000000,16.662400>}
box{<0,0,-0.152400><0.609600,0.035000,0.152400> rotate<0,0.000000,0> translate<2.641600,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.251200,-1.535000,23.977600>}
box{<0,0,-0.152400><0.609600,0.035000,0.152400> rotate<0,0.000000,0> translate<2.641600,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.810000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.267200,-1.535000,35.560000>}
box{<0,0,-0.152400><0.457200,0.035000,0.152400> rotate<0,0.000000,0> translate<3.810000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.251200,-1.535000,13.614400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.486400,-1.535000,13.614400>}
box{<0,0,-0.152400><2.235200,0.035000,0.152400> rotate<0,0.000000,0> translate<3.251200,-1.535000,13.614400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.486400,-1.535000,18.694400>}
box{<0,0,-0.152400><4.023155,0.035000,0.152400> rotate<0,44.997030,0> translate<2.641600,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.486400,-1.535000,13.614400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.299200,-1.535000,12.801600>}
box{<0,0,-0.152400><1.149473,0.035000,0.152400> rotate<0,44.997030,0> translate<5.486400,-1.535000,13.614400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.502400,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.502400,0.000000,14.020800>}
box{<0,0,-0.152400><5.486400,0.035000,0.152400> rotate<0,90.000000,0> translate<6.502400,0.000000,14.020800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.251200,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.315200,0.000000,20.726400>}
box{<0,0,-0.152400><5.747364,0.035000,0.152400> rotate<0,-44.997030,0> translate<3.251200,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.251200,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.518400,-1.535000,19.710400>}
box{<0,0,-0.152400><6.034732,0.035000,0.152400> rotate<0,44.997030,0> translate<3.251200,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.267200,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.518400,-1.535000,38.811200>}
box{<0,0,-0.152400><4.597891,0.035000,0.152400> rotate<0,-44.997030,0> translate<4.267200,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.518400,-1.535000,19.710400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.721600,-1.535000,19.710400>}
box{<0,0,-0.152400><0.203200,0.035000,0.152400> rotate<0,0.000000,0> translate<7.518400,-1.535000,19.710400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.620000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.721600,0.000000,50.800000>}
box{<0,0,-0.152400><0.101600,0.035000,0.152400> rotate<0,0.000000,0> translate<7.620000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.721600,0.000000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.721600,0.000000,50.800000>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,90.000000,0> translate<7.721600,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.315200,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.128000,0.000000,20.726400>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,0.000000,0> translate<7.315200,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.299200,-1.535000,12.801600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.534400,-1.535000,12.801600>}
box{<0,0,-0.152400><2.235200,0.035000,0.152400> rotate<0,0.000000,0> translate<6.299200,-1.535000,12.801600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.502400,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,0.000000,6.299200>}
box{<0,0,-0.152400><3.161050,0.035000,0.152400> rotate<0,44.997030,0> translate<6.502400,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.486400,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,-1.535000,18.694400>}
box{<0,0,-0.152400><3.251200,0.035000,0.152400> rotate<0,0.000000,0> translate<5.486400,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.721600,0.000000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,0.000000,48.971200>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<7.721600,0.000000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,0.000000,48.361600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,0.000000,48.971200>}
box{<0,0,-0.152400><0.609600,0.035000,0.152400> rotate<0,90.000000,0> translate<8.737600,0.000000,48.971200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,-1.535000,58.115200>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,90.000000,0> translate<8.737600,-1.535000,58.115200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.763000,-1.535000,57.150000>}
box{<0,0,-0.152400><0.154502,0.035000,0.152400> rotate<0,80.532363,0> translate<8.737600,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,0.000000,6.299200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.890000,0.000000,6.350000>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,-18.433732,0> translate<8.737600,0.000000,6.299200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,0.000000,48.361600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.890000,0.000000,48.260000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,33.687844,0> translate<8.737600,0.000000,48.361600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.890000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.940800,-1.535000,45.720000>}
box{<0,0,-0.152400><0.050800,0.035000,0.152400> rotate<0,0.000000,0> translate<8.890000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.890000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.940800,-1.535000,48.158400>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,63.430762,0> translate<8.890000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.641600,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.940800,-1.535000,57.099200>}
box{<0,0,-0.152400><8.908414,0.035000,0.152400> rotate<0,-44.997030,0> translate<2.641600,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.763000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.940800,-1.535000,57.099200>}
box{<0,0,-0.152400><0.184915,0.035000,0.152400> rotate<0,15.944344,0> translate<8.763000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.534400,-1.535000,12.801600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.550400,-1.535000,13.817600>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<8.534400,-1.535000,12.801600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.347200,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.601200,-1.535000,13.690600>}
box{<0,0,-0.152400><0.377598,0.035000,0.152400> rotate<0,-47.723161,0> translate<9.347200,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.550400,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.601200,-1.535000,13.690600>}
box{<0,0,-0.152400><0.136783,0.035000,0.152400> rotate<0,68.194090,0> translate<9.550400,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,-1.535000,58.115200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.956800,-1.535000,59.334400>}
box{<0,0,-0.152400><1.724209,0.035000,0.152400> rotate<0,-44.997030,0> translate<8.737600,-1.535000,58.115200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.160000,-1.535000,30.683200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.160000,-1.535000,36.830000>}
box{<0,0,-0.152400><6.146800,0.035000,0.152400> rotate<0,90.000000,0> translate<10.160000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.518400,-1.535000,38.811200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.769600,-1.535000,38.811200>}
box{<0,0,-0.152400><3.251200,0.035000,0.152400> rotate<0,0.000000,0> translate<7.518400,-1.535000,38.811200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.502400,-1.535000,14.020800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.379200,-1.535000,18.897600>}
box{<0,0,-0.152400><6.896837,0.035000,0.152400> rotate<0,-44.997030,0> translate<6.502400,-1.535000,14.020800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.430000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.582400,-1.535000,6.502400>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,-44.997030,0> translate<11.430000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.582400,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.582400,-1.535000,6.908800>}
box{<0,0,-0.152400><0.406400,0.035000,0.152400> rotate<0,90.000000,0> translate<11.582400,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.557000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.582400,-1.535000,57.099200>}
box{<0,0,-0.406400><0.056796,0.035000,0.406400> rotate<0,63.430762,0> translate<11.557000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.128000,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.192000,0.000000,16.662400>}
box{<0,0,-0.152400><5.747364,0.035000,0.152400> rotate<0,44.997030,0> translate<8.128000,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.160000,-1.535000,30.683200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.496800,-1.535000,28.346400>}
box{<0,0,-0.152400><3.304734,0.035000,0.152400> rotate<0,44.997030,0> translate<10.160000,-1.535000,30.683200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.347200,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.598400,-1.535000,10.160000>}
box{<0,0,-0.152400><4.597891,0.035000,0.152400> rotate<0,44.997030,0> translate<9.347200,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.769600,-1.535000,38.811200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.598400,-1.535000,36.982400>}
box{<0,0,-0.152400><2.586314,0.035000,0.152400> rotate<0,44.997030,0> translate<10.769600,-1.535000,38.811200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.940800,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.598400,-1.535000,42.062400>}
box{<0,0,-0.152400><5.172628,0.035000,0.152400> rotate<0,44.997030,0> translate<8.940800,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.598400,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.700000,-1.535000,10.160000>}
box{<0,0,-0.152400><0.101600,0.035000,0.152400> rotate<0,0.000000,0> translate<12.598400,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.598400,-1.535000,36.982400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.700000,-1.535000,36.830000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,56.306216,0> translate<12.598400,-1.535000,36.982400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.598400,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.700000,-1.535000,41.910000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,56.306216,0> translate<12.598400,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.582400,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.004800,-1.535000,8.331200>}
box{<0,0,-0.152400><2.011577,0.035000,0.152400> rotate<0,-44.997030,0> translate<11.582400,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.956800,-1.535000,59.334400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.004800,-1.535000,59.334400>}
box{<0,0,-0.152400><3.048000,0.035000,0.152400> rotate<0,0.000000,0> translate<9.956800,-1.535000,59.334400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.737600,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.614400,-1.535000,23.571200>}
box{<0,0,-0.152400><6.896837,0.035000,0.152400> rotate<0,-44.997030,0> translate<8.737600,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.379200,-1.535000,18.897600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.817600,-1.535000,18.897600>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,0.000000,0> translate<11.379200,-1.535000,18.897600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.817600,-1.535000,18.897600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.970000,-1.535000,19.050000>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,-44.997030,0> translate<13.817600,-1.535000,18.897600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.970000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,0.000000,6.502400>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,-71.560328,0> translate<13.970000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.970000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,-1.535000,6.502400>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,-71.560328,0> translate<13.970000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,-1.535000,6.908800>}
box{<0,0,-0.152400><0.406400,0.035000,0.152400> rotate<0,90.000000,0> translate<14.020800,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,0.000000,7.315200>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,90.000000,0> translate<14.020800,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.970000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,-1.535000,25.400000>}
box{<0,0,-0.152400><0.050800,0.035000,0.152400> rotate<0,0.000000,0> translate<13.970000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.496800,-1.535000,28.346400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,-1.535000,26.822400>}
box{<0,0,-0.152400><2.155261,0.035000,0.152400> rotate<0,44.997030,0> translate<12.496800,-1.535000,28.346400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,-1.535000,26.822400>}
box{<0,0,-0.152400><1.422400,0.035000,0.152400> rotate<0,90.000000,0> translate<14.020800,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.582400,-1.535000,57.099200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.020800,-1.535000,54.660800>}
box{<0,0,-0.406400><3.448418,0.035000,0.406400> rotate<0,44.997030,0> translate<11.582400,-1.535000,57.099200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.004800,-1.535000,8.331200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.427200,-1.535000,8.331200>}
box{<0,0,-0.152400><1.422400,0.035000,0.152400> rotate<0,0.000000,0> translate<13.004800,-1.535000,8.331200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.614400,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.630400,-1.535000,23.571200>}
box{<0,0,-0.152400><1.016000,0.035000,0.152400> rotate<0,0.000000,0> translate<13.614400,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.192000,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.833600,0.000000,16.662400>}
box{<0,0,-0.152400><2.641600,0.035000,0.152400> rotate<0,0.000000,0> translate<12.192000,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.004800,-1.535000,59.334400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.036800,-1.535000,57.302400>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,44.997030,0> translate<13.004800,-1.535000,59.334400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.036800,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.113000,-1.535000,57.150000>}
box{<0,0,-0.152400><0.170388,0.035000,0.152400> rotate<0,63.430762,0> translate<15.036800,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.240000,0.000000,8.534400>}
box{<0,0,-0.152400><1.724209,0.035000,0.152400> rotate<0,-44.997030,0> translate<14.020800,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.721600,0.000000,19.710400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.240000,0.000000,12.192000>}
box{<0,0,-0.152400><10.632623,0.035000,0.152400> rotate<0,44.997030,0> translate<7.721600,0.000000,19.710400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.240000,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.240000,0.000000,12.192000>}
box{<0,0,-0.152400><3.657600,0.035000,0.152400> rotate<0,90.000000,0> translate<15.240000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.240000,-1.535000,47.345600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.240000,-1.535000,46.990000>}
box{<0,0,-0.152400><0.355600,0.035000,0.152400> rotate<0,-90.000000,0> translate<15.240000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.940800,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.849600,-1.535000,48.158400>}
box{<0,0,-0.152400><6.908800,0.035000,0.152400> rotate<0,0.000000,0> translate<8.940800,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.240000,-1.535000,47.345600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.951200,-1.535000,48.056800>}
box{<0,0,-0.152400><1.005789,0.035000,0.152400> rotate<0,-44.997030,0> translate<15.240000,-1.535000,47.345600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.849600,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.951200,-1.535000,48.056800>}
box{<0,0,-0.152400><0.143684,0.035000,0.152400> rotate<0,44.997030,0> translate<15.849600,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.970000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.052800,-1.535000,19.507200>}
box{<0,0,-0.152400><2.945524,0.035000,0.152400> rotate<0,44.997030,0> translate<13.970000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.052800,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.052800,-1.535000,19.507200>}
box{<0,0,-0.152400><5.689600,0.035000,0.152400> rotate<0,90.000000,0> translate<16.052800,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.598400,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.154400,-1.535000,13.716000>}
box{<0,0,-0.152400><5.028943,0.035000,0.152400> rotate<0,-44.997030,0> translate<12.598400,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.052800,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.154400,-1.535000,13.716000>}
box{<0,0,-0.152400><0.143684,0.035000,0.152400> rotate<0,44.997030,0> translate<16.052800,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.154400,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.256000,-1.535000,13.817600>}
box{<0,0,-0.152400><0.143684,0.035000,0.152400> rotate<0,-44.997030,0> translate<16.154400,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.496800,-1.535000,28.346400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.459200,-1.535000,32.308800>}
box{<0,0,-0.152400><5.603680,0.035000,0.152400> rotate<0,-44.997030,0> translate<12.496800,-1.535000,28.346400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.459200,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.459200,-1.535000,32.918400>}
box{<0,0,-0.152400><0.609600,0.035000,0.152400> rotate<0,90.000000,0> translate<16.459200,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.970000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.510000,0.000000,25.400000>}
box{<0,0,-0.152400><2.540000,0.035000,0.152400> rotate<0,0.000000,0> translate<13.970000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.459200,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.510000,-1.535000,33.020000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,-63.430762,0> translate<16.459200,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.630400,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.662400,-1.535000,21.539200>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,44.997030,0> translate<14.630400,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.662400,-1.535000,19.710400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.662400,-1.535000,21.539200>}
box{<0,0,-0.152400><1.828800,0.035000,0.152400> rotate<0,90.000000,0> translate<16.662400,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.510000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.662400,0.000000,33.121600>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,-33.687844,0> translate<16.510000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.833600,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.865600,0.000000,18.694400>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,-44.997030,0> translate<14.833600,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.256000,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.678400,-1.535000,13.817600>}
box{<0,0,-0.152400><1.422400,0.035000,0.152400> rotate<0,0.000000,0> translate<16.256000,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.678400,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.780000,-1.535000,13.970000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,-56.306216,0> translate<17.678400,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.780000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.881600,0.000000,21.742400>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,-56.306216,0> translate<17.780000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.881600,0.000000,21.742400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.881600,0.000000,29.464000>}
box{<0,0,-0.152400><7.721600,0.035000,0.152400> rotate<0,90.000000,0> translate<17.881600,0.000000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.240000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.881600,0.000000,53.441600>}
box{<0,0,-0.152400><3.735787,0.035000,0.152400> rotate<0,-44.997030,0> translate<15.240000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.881600,0.000000,53.441600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.881600,0.000000,57.099200>}
box{<0,0,-0.152400><3.657600,0.035000,0.152400> rotate<0,90.000000,0> translate<17.881600,0.000000,57.099200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.881600,0.000000,57.099200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.907000,0.000000,57.150000>}
box{<0,0,-0.152400><0.056796,0.035000,0.152400> rotate<0,-63.430762,0> translate<17.881600,0.000000,57.099200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.427200,-1.535000,8.331200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.897600,-1.535000,12.801600>}
box{<0,0,-0.152400><6.322100,0.035000,0.152400> rotate<0,-44.997030,0> translate<14.427200,-1.535000,8.331200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.897600,-1.535000,12.801600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.897600,-1.535000,14.833600>}
box{<0,0,-0.152400><2.032000,0.035000,0.152400> rotate<0,90.000000,0> translate<18.897600,-1.535000,14.833600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.662400,0.000000,33.121600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.897600,0.000000,33.121600>}
box{<0,0,-0.152400><2.235200,0.035000,0.152400> rotate<0,0.000000,0> translate<16.662400,0.000000,33.121600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.897600,0.000000,33.121600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.050000,0.000000,33.020000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,33.687844,0> translate<18.897600,0.000000,33.121600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.050000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.100800,-1.535000,25.400000>}
box{<0,0,-0.152400><0.050800,0.035000,0.152400> rotate<0,0.000000,0> translate<19.050000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.100800,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.100800,-1.535000,29.870400>}
box{<0,0,-0.152400><4.470400,0.035000,0.152400> rotate<0,90.000000,0> translate<19.100800,-1.535000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.881600,0.000000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.116800,0.000000,31.699200>}
box{<0,0,-0.152400><3.161050,0.035000,0.152400> rotate<0,-44.997030,0> translate<17.881600,0.000000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.116800,0.000000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.116800,0.000000,39.014400>}
box{<0,0,-0.152400><7.315200,0.035000,0.152400> rotate<0,90.000000,0> translate<20.116800,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.020800,-1.535000,54.660800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.116800,-1.535000,54.660800>}
box{<0,0,-0.406400><6.096000,0.035000,0.406400> rotate<0,0.000000,0> translate<14.020800,-1.535000,54.660800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.662400,-1.535000,19.710400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.218400,-1.535000,16.154400>}
box{<0,0,-0.152400><5.028943,0.035000,0.152400> rotate<0,44.997030,0> translate<16.662400,-1.535000,19.710400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.897600,-1.535000,14.833600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.218400,-1.535000,16.154400>}
box{<0,0,-0.152400><1.867893,0.035000,0.152400> rotate<0,-44.997030,0> translate<18.897600,-1.535000,14.833600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.020800,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.320000,-1.535000,13.208000>}
box{<0,0,-0.152400><8.908414,0.035000,0.152400> rotate<0,-44.997030,0> translate<14.020800,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.320000,-1.535000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.320000,-1.535000,13.970000>}
box{<0,0,-0.152400><0.762000,0.035000,0.152400> rotate<0,90.000000,0> translate<20.320000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.320000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.320000,-1.535000,21.742400>}
box{<0,0,-0.152400><0.152400,0.035000,0.152400> rotate<0,90.000000,0> translate<20.320000,-1.535000,21.742400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.218400,-1.535000,16.154400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.523200,-1.535000,16.459200>}
box{<0,0,-0.152400><0.431052,0.035000,0.152400> rotate<0,-44.997030,0> translate<20.218400,-1.535000,16.154400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.320000,-1.535000,21.742400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.726400,-1.535000,21.742400>}
box{<0,0,-0.152400><0.406400,0.035000,0.152400> rotate<0,0.000000,0> translate<20.320000,-1.535000,21.742400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.523200,-1.535000,16.459200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.132800,-1.535000,16.459200>}
box{<0,0,-0.152400><0.609600,0.035000,0.152400> rotate<0,0.000000,0> translate<20.523200,-1.535000,16.459200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.100800,-1.535000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.539200,-1.535000,32.308800>}
box{<0,0,-0.152400><3.448418,0.035000,0.152400> rotate<0,-44.997030,0> translate<19.100800,-1.535000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.539200,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.539200,-1.535000,32.918400>}
box{<0,0,-0.152400><0.609600,0.035000,0.152400> rotate<0,90.000000,0> translate<21.539200,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.539200,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.590000,-1.535000,33.020000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,-63.430762,0> translate<21.539200,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.742400,0.000000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.742400,0.000000,32.105600>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,-90.000000,0> translate<21.742400,0.000000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.590000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.742400,0.000000,32.918400>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,33.687844,0> translate<21.590000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.951200,-1.535000,48.056800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.352000,-1.535000,54.457600>}
box{<0,0,-0.152400><9.052098,0.035000,0.152400> rotate<0,-44.997030,0> translate<15.951200,-1.535000,48.056800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.758400,-1.535000,14.833600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.758400,-1.535000,14.020800>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,-90.000000,0> translate<22.758400,-1.535000,14.020800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.132800,-1.535000,16.459200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.758400,-1.535000,14.833600>}
box{<0,0,-0.152400><2.298946,0.035000,0.152400> rotate<0,44.997030,0> translate<21.132800,-1.535000,16.459200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.758400,-1.535000,14.020800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,13.970000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,26.563298,0> translate<22.758400,-1.535000,14.020800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,21.539200>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,26.563298,0> translate<22.860000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,21.539200>}
box{<0,0,-0.152400><5.283200,0.035000,0.152400> rotate<0,90.000000,0> translate<22.961600,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.116800,-1.535000,54.660800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.368000,-1.535000,57.912000>}
box{<0,0,-0.406400><4.597891,0.035000,0.406400> rotate<0,-44.997030,0> translate<20.116800,-1.535000,54.660800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.726400,-1.535000,21.742400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.571200,-1.535000,24.587200>}
box{<0,0,-0.152400><4.023155,0.035000,0.152400> rotate<0,-44.997030,0> translate<20.726400,-1.535000,21.742400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.571200,-1.535000,24.587200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.571200,-1.535000,35.153600>}
box{<0,0,-0.152400><10.566400,0.035000,0.152400> rotate<0,90.000000,0> translate<23.571200,-1.535000,35.153600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,15.240000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<22.961600,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,15.240000>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,90.000000,0> translate<23.977600,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.352000,-1.535000,54.457600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,54.457600>}
box{<0,0,-0.152400><1.625600,0.035000,0.152400> rotate<0,0.000000,0> translate<22.352000,-1.535000,54.457600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,54.457600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.130000,-1.535000,54.610000>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,-44.997030,0> translate<23.977600,-1.535000,54.457600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.180800,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.180800,0.000000,15.036800>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,90.000000,0> translate<24.180800,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.742400,0.000000,32.105600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.180800,0.000000,29.667200>}
box{<0,0,-0.152400><3.448418,0.035000,0.152400> rotate<0,44.997030,0> translate<21.742400,0.000000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,0.000000,5.207000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,90.000000,0> translate<25.400000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,7.721600>}
box{<0,0,-0.152400><2.011577,0.035000,0.152400> rotate<0,44.997030,0> translate<23.977600,-1.535000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,7.747000>}
box{<0,0,-0.152400><0.025400,0.035000,0.152400> rotate<0,90.000000,0> translate<25.400000,-1.535000,7.747000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,13.970000>}
box{<0,0,-0.152400><0.762000,0.035000,0.152400> rotate<0,90.000000,0> translate<25.400000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.180800,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,0.000000,16.256000>}
box{<0,0,-0.152400><1.724209,0.035000,0.152400> rotate<0,-44.997030,0> translate<24.180800,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,21.590000>}
box{<0,0,-0.152400><5.334000,0.035000,0.152400> rotate<0,90.000000,0> translate<25.400000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.822400,0.000000,11.988800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.822400,0.000000,15.240000>}
box{<0,0,-0.152400><3.251200,0.035000,0.152400> rotate<0,90.000000,0> translate<26.822400,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.670000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.822400,0.000000,41.859200>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,18.433732,0> translate<26.670000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.180800,0.000000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.000200,0.000000,29.667200>}
box{<0,0,-0.152400><2.819400,0.035000,0.152400> rotate<0,0.000000,0> translate<24.180800,0.000000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.000200,0.000000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.051000,0.000000,29.718000>}
box{<0,0,-0.152400><0.071842,0.035000,0.152400> rotate<0,-44.997030,0> translate<27.000200,0.000000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,0.000000,5.080000>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,0.000000,0> translate<25.400000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.180800,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,0.000000,8.940800>}
box{<0,0,-0.152400><5.172628,0.035000,0.152400> rotate<0,44.997030,0> translate<24.180800,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,0.000000,8.940800>}
box{<0,0,-0.152400><1.422400,0.035000,0.152400> rotate<0,90.000000,0> translate<27.838400,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.822400,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,0.000000,16.256000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<26.822400,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,-1.535000,21.539200>}
box{<0,0,-0.152400><5.283200,0.035000,0.152400> rotate<0,90.000000,0> translate<27.838400,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.940000,0.000000,4.953000>}
box{<0,0,-0.152400><0.162639,0.035000,0.152400> rotate<0,51.336803,0> translate<27.838400,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.940000,0.000000,7.493000>}
box{<0,0,-0.152400><0.104727,0.035000,0.152400> rotate<0,14.035317,0> translate<27.838400,0.000000,7.518400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.838400,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.940000,-1.535000,21.590000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,-26.563298,0> translate<27.838400,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.940000,0.000000,4.953000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.041600,0.000000,5.080000>}
box{<0,0,-0.152400><0.162639,0.035000,0.152400> rotate<0,-51.336803,0> translate<27.940000,0.000000,4.953000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.940000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.041600,-1.535000,14.020800>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,-26.563298,0> translate<27.940000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.041600,-1.535000,14.020800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.041600,-1.535000,14.833600>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,90.000000,0> translate<28.041600,-1.535000,14.833600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.854400,-1.535000,9.753600>}
box{<0,0,-0.152400><4.885259,0.035000,0.152400> rotate<0,44.997030,0> translate<25.400000,-1.535000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.116800,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.854400,0.000000,47.752000>}
box{<0,0,-0.152400><12.356832,0.035000,0.152400> rotate<0,-44.997030,0> translate<20.116800,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.260800,0.000000,12.801600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.260800,0.000000,15.036800>}
box{<0,0,-0.152400><2.235200,0.035000,0.152400> rotate<0,90.000000,0> translate<29.260800,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.041600,-1.535000,14.833600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870400,-1.535000,16.662400>}
box{<0,0,-0.152400><2.586314,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.041600,-1.535000,14.833600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.571200,-1.535000,35.153600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870400,-1.535000,41.452800>}
box{<0,0,-0.152400><8.908414,0.035000,0.152400> rotate<0,-44.997030,0> translate<23.571200,-1.535000,35.153600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.051000,-1.535000,29.718000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.226000,-1.535000,29.718000>}
box{<0,0,-0.152400><3.175000,0.035000,0.152400> rotate<0,0.000000,0> translate<27.051000,-1.535000,29.718000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.226000,0.000000,29.718000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.353000,0.000000,29.845000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<30.226000,0.000000,29.718000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.041600,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,5.080000>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,0.000000,0> translate<28.041600,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,5.207000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,90.000000,0> translate<30.480000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,8.331200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,7.747000>}
box{<0,0,-0.152400><0.584200,0.035000,0.152400> rotate<0,-90.000000,0> translate<30.480000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.822400,0.000000,11.988800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,8.331200>}
box{<0,0,-0.152400><5.172628,0.035000,0.152400> rotate<0,44.997030,0> translate<26.822400,0.000000,11.988800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,13.970000>}
box{<0,0,-0.152400><1.371600,0.035000,0.152400> rotate<0,90.000000,0> translate<30.480000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.260800,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,16.256000>}
box{<0,0,-0.152400><1.724209,0.035000,0.152400> rotate<0,-44.997030,0> translate<29.260800,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,17.678400>}
box{<0,0,-0.152400><1.422400,0.035000,0.152400> rotate<0,90.000000,0> translate<30.480000,0.000000,17.678400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,-1.535000,17.678400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,-1.535000,21.590000>}
box{<0,0,-0.152400><3.911600,0.035000,0.152400> rotate<0,90.000000,0> translate<30.480000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.822400,0.000000,41.859200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.632400,0.000000,38.049200>}
box{<0,0,-0.152400><5.388154,0.035000,0.152400> rotate<0,44.997030,0> translate<26.822400,0.000000,41.859200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.632400,-1.535000,37.947600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.632400,-1.535000,38.049200>}
box{<0,0,-0.152400><0.101600,0.035000,0.152400> rotate<0,90.000000,0> translate<30.632400,-1.535000,38.049200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.632400,-1.535000,37.947600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.750000,-1.535000,36.830000>}
box{<0,0,-0.152400><1.580525,0.035000,0.152400> rotate<0,44.997030,0> translate<30.632400,-1.535000,37.947600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.750000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.902400,-1.535000,28.854400>}
box{<0,0,-0.152400><7.977056,0.035000,0.152400> rotate<0,88.899442,0> translate<31.750000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,0.000000,5.080000>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,0.000000,0> translate<30.480000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.260800,0.000000,12.801600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,0.000000,9.144000>}
box{<0,0,-0.152400><5.172628,0.035000,0.152400> rotate<0,44.997030,0> translate<29.260800,0.000000,12.801600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,0.000000,9.144000>}
box{<0,0,-0.152400><1.625600,0.035000,0.152400> rotate<0,90.000000,0> translate<32.918400,0.000000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.902400,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,-1.535000,27.838400>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<31.902400,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,-1.535000,27.838400>}
box{<0,0,-0.152400><1.016000,0.035000,0.152400> rotate<0,90.000000,0> translate<32.918400,-1.535000,27.838400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.020000,0.000000,4.953000>}
box{<0,0,-0.152400><0.162639,0.035000,0.152400> rotate<0,51.336803,0> translate<32.918400,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.020000,0.000000,7.493000>}
box{<0,0,-0.152400><0.104727,0.035000,0.152400> rotate<0,14.035317,0> translate<32.918400,0.000000,7.518400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.865600,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.020000,0.000000,18.796000>}
box{<0,0,-0.152400><16.154719,0.035000,0.152400> rotate<0,-0.360322,0> translate<16.865600,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.918400,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.020000,-1.535000,26.670000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,56.306216,0> translate<32.918400,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.020000,0.000000,4.953000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,0.000000,5.080000>}
box{<0,0,-0.152400><0.162639,0.035000,0.152400> rotate<0,-51.336803,0> translate<33.020000,0.000000,4.953000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.480000,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,0.000000,9.956800>}
box{<0,0,-0.152400><3.735787,0.035000,0.152400> rotate<0,44.997030,0> translate<30.480000,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.020000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,0.000000,18.694400>}
box{<0,0,-0.152400><0.143684,0.035000,0.152400> rotate<0,44.997030,0> translate<33.020000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,-1.535000,26.619200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,-1.535000,25.806400>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,-90.000000,0> translate<33.121600,-1.535000,25.806400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.020000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,-1.535000,26.619200>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,26.563298,0> translate<33.020000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.854400,0.000000,47.752000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.324800,0.000000,47.752000>}
box{<0,0,-0.152400><4.470400,0.035000,0.152400> rotate<0,0.000000,0> translate<28.854400,0.000000,47.752000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.854400,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.528000,-1.535000,9.753600>}
box{<0,0,-0.152400><4.673600,0.035000,0.152400> rotate<0,0.000000,0> translate<28.854400,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.368000,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.934400,-1.535000,57.912000>}
box{<0,0,-0.406400><10.566400,0.035000,0.406400> rotate<0,0.000000,0> translate<23.368000,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,-1.535000,25.806400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.747200,-1.535000,24.180800>}
box{<0,0,-0.152400><2.298946,0.035000,0.152400> rotate<0,44.997030,0> translate<33.121600,-1.535000,25.806400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.353000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.925000,0.000000,29.845000>}
box{<0,0,-0.152400><4.572000,0.035000,0.152400> rotate<0,0.000000,0> translate<30.353000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.925000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.102800,0.000000,29.667200>}
box{<0,0,-0.152400><0.251447,0.035000,0.152400> rotate<0,44.997030,0> translate<34.925000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,0.000000,9.956800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.356800,0.000000,9.956800>}
box{<0,0,-0.152400><2.235200,0.035000,0.152400> rotate<0,0.000000,0> translate<33.121600,0.000000,9.956800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,0.000000,5.080000>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,0.000000,0> translate<33.121600,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,0.000000,5.207000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,90.000000,0> translate<35.560000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.528000,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,7.721600>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,44.997030,0> translate<33.528000,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,7.747000>}
box{<0,0,-0.152400><0.025400,0.035000,0.152400> rotate<0,90.000000,0> translate<35.560000,-1.535000,7.747000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,26.619200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,26.670000>}
box{<0,0,-0.152400><0.050800,0.035000,0.152400> rotate<0,90.000000,0> translate<35.560000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.356800,-1.535000,9.956800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.966400,-1.535000,9.347200>}
box{<0,0,-0.152400><0.862105,0.035000,0.152400> rotate<0,44.997030,0> translate<35.356800,-1.535000,9.956800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870400,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.576000,-1.535000,41.452800>}
box{<0,0,-0.152400><6.705600,0.035000,0.152400> rotate<0,0.000000,0> translate<29.870400,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.324800,0.000000,47.752000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.779200,0.000000,44.297600>}
box{<0,0,-0.152400><4.885259,0.035000,0.152400> rotate<0,44.997030,0> translate<33.324800,0.000000,47.752000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.779200,0.000000,44.297600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.830000,0.000000,44.450000>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,-71.560328,0> translate<36.779200,0.000000,44.297600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.830000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.982400,-1.535000,39.217600>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,44.997030,0> translate<36.830000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.576000,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.982400,-1.535000,41.859200>}
box{<0,0,-0.152400><0.574736,0.035000,0.152400> rotate<0,-44.997030,0> translate<36.576000,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.830000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.982400,-1.535000,44.297600>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,44.997030,0> translate<36.830000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.830000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.982400,-1.535000,49.377600>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,44.997030,0> translate<36.830000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.982400,-1.535000,41.859200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.084000,-1.535000,41.910000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,-26.563298,0> translate<36.982400,-1.535000,41.859200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.084000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.185600,-1.535000,42.062400>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,-56.306216,0> translate<37.084000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,26.619200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.388800,-1.535000,24.790400>}
box{<0,0,-0.152400><2.586314,0.035000,0.152400> rotate<0,44.997030,0> translate<35.560000,-1.535000,26.619200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870400,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.795200,-1.535000,16.662400>}
box{<0,0,-0.152400><7.924800,0.035000,0.152400> rotate<0,0.000000,0> translate<29.870400,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.998400,0.000000,8.331200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.998400,0.000000,7.518400>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,-90.000000,0> translate<37.998400,0.000000,7.518400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.998400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,0.000000,7.493000>}
box{<0,0,-0.152400><0.104727,0.035000,0.152400> rotate<0,14.035317,0> translate<37.998400,0.000000,7.518400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,0.000000,4.953000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,0.000000,5.080000>}
box{<0,0,-0.152400><0.162639,0.035000,0.152400> rotate<0,-51.336803,0> translate<38.100000,0.000000,4.953000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,-1.535000,14.020800>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,-26.563298,0> translate<38.100000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,-1.535000,14.020800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,-1.535000,14.833600>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,90.000000,0> translate<38.201600,-1.535000,14.833600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.795200,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,-1.535000,16.256000>}
box{<0,0,-0.152400><0.574736,0.035000,0.152400> rotate<0,44.997030,0> translate<37.795200,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,0.000000,26.619200>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,26.563298,0> translate<38.100000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,0.000000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,0.000000,26.619200>}
box{<0,0,-0.152400><1.016000,0.035000,0.152400> rotate<0,90.000000,0> translate<38.201600,0.000000,26.619200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.747200,-1.535000,24.180800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.811200,-1.535000,24.180800>}
box{<0,0,-0.152400><4.064000,0.035000,0.152400> rotate<0,0.000000,0> translate<34.747200,-1.535000,24.180800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.388800,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.014400,-1.535000,24.790400>}
box{<0,0,-0.152400><1.625600,0.035000,0.152400> rotate<0,0.000000,0> translate<37.388800,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.966400,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.217600,-1.535000,9.347200>}
box{<0,0,-0.152400><3.251200,0.035000,0.152400> rotate<0,0.000000,0> translate<35.966400,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.998400,0.000000,8.331200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.217600,0.000000,9.550400>}
box{<0,0,-0.152400><1.724209,0.035000,0.152400> rotate<0,-44.997030,0> translate<37.998400,0.000000,8.331200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.217600,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.217600,0.000000,9.550400>}
box{<0,0,-0.152400><5.689600,0.035000,0.152400> rotate<0,-90.000000,0> translate<39.217600,0.000000,9.550400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.217600,0.000000,15.240000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<38.201600,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.934400,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.420800,-1.535000,52.425600>}
box{<0,0,-0.406400><7.758941,0.035000,0.406400> rotate<0,44.997030,0> translate<33.934400,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,59.309000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.420800,-1.535000,59.131200>}
box{<0,0,-0.152400><0.184915,0.035000,0.152400> rotate<0,74.049717,0> translate<39.370000,-1.535000,59.309000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,-1.535000,14.833600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.827200,-1.535000,16.459200>}
box{<0,0,-0.152400><2.298946,0.035000,0.152400> rotate<0,-44.997030,0> translate<38.201600,-1.535000,14.833600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,0.000000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.827200,0.000000,23.977600>}
box{<0,0,-0.152400><2.298946,0.035000,0.152400> rotate<0,44.997030,0> translate<38.201600,0.000000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.014400,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.827200,-1.535000,23.977600>}
box{<0,0,-0.152400><1.149473,0.035000,0.152400> rotate<0,44.997030,0> translate<39.014400,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.420800,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.030400,-1.535000,59.131200>}
box{<0,0,-0.152400><0.609600,0.035000,0.152400> rotate<0,0.000000,0> translate<39.420800,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.420800,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.436800,-1.535000,52.425600>}
box{<0,0,-0.406400><1.016000,0.035000,0.406400> rotate<0,0.000000,0> translate<39.420800,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.201600,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,5.080000>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,0.000000,0> translate<38.201600,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,5.207000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,90.000000,0> translate<40.640000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,7.924800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,7.747000>}
box{<0,0,-0.152400><0.177800,0.035000,0.152400> rotate<0,-90.000000,0> translate<40.640000,-1.535000,7.747000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.217600,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,7.924800>}
box{<0,0,-0.152400><2.011577,0.035000,0.152400> rotate<0,44.997030,0> translate<39.217600,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,13.970000>}
box{<0,0,-0.152400><1.371600,0.035000,0.152400> rotate<0,90.000000,0> translate<40.640000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,21.590000>}
box{<0,0,-0.152400><0.762000,0.035000,0.152400> rotate<0,-90.000000,0> translate<40.640000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.811200,-1.535000,24.180800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,22.352000>}
box{<0,0,-0.152400><2.586314,0.035000,0.152400> rotate<0,44.997030,0> translate<38.811200,-1.535000,24.180800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,34.290000>}
box{<0,0,-0.152400><0.965200,0.035000,0.152400> rotate<0,90.000000,0> translate<40.640000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.030400,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.859200,-1.535000,57.302400>}
box{<0,0,-0.152400><2.586314,0.035000,0.152400> rotate<0,44.997030,0> translate<40.030400,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.265600,0.000000,10.972800>}
box{<0,0,-0.152400><2.298946,0.035000,0.152400> rotate<0,44.997030,0> translate<40.640000,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.436800,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<42.468800,-1.535000,54.457600>}
box{<0,0,-0.406400><2.873682,0.035000,0.406400> rotate<0,-44.997030,0> translate<40.436800,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,0.000000,31.292800>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,44.997030,0> translate<40.640000,0.000000,33.324800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.046400,0.000000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,0.000000,58.318400>}
box{<0,0,-0.152400><2.298946,0.035000,0.152400> rotate<0,-44.997030,0> translate<41.046400,0.000000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.078400,0.000000,5.080000>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,0.000000,0> translate<40.640000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.982400,-1.535000,39.217600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.078400,-1.535000,39.217600>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<36.982400,-1.535000,39.217600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.982400,-1.535000,44.297600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.078400,-1.535000,44.297600>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<36.982400,-1.535000,44.297600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.982400,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.078400,-1.535000,49.377600>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<36.982400,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.078400,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,0.000000,4.953000>}
box{<0,0,-0.152400><0.162639,0.035000,0.152400> rotate<0,51.336803,0> translate<43.078400,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.078400,-1.535000,39.217600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,39.370000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,-56.306216,0> translate<43.078400,-1.535000,39.217600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.078400,-1.535000,44.297600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,44.450000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,-56.306216,0> translate<43.078400,-1.535000,44.297600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.078400,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,49.530000>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,-56.306216,0> translate<43.078400,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,0.000000,4.953000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,0.000000,5.080000>}
box{<0,0,-0.152400><0.162639,0.035000,0.152400> rotate<0,-51.336803,0> translate<43.180000,0.000000,4.953000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,7.493000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,7.518400>}
box{<0,0,-0.152400><0.104727,0.035000,0.152400> rotate<0,-14.035317,0> translate<43.180000,-1.535000,7.493000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,13.817600>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,56.306216,0> translate<43.180000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,7.518400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,13.817600>}
box{<0,0,-0.152400><6.299200,0.035000,0.152400> rotate<0,90.000000,0> translate<43.281600,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,39.217600>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,56.306216,0> translate<43.180000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.185600,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,42.062400>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.185600,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,44.297600>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,56.306216,0> translate<43.180000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,49.377600>}
box{<0,0,-0.152400><0.183162,0.035000,0.152400> rotate<0,56.306216,0> translate<43.180000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.434000,-1.535000,41.910000>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,44.997030,0> translate<43.281600,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.121600,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.484800,-1.535000,18.694400>}
box{<0,0,-0.152400><10.363200,0.035000,0.152400> rotate<0,0.000000,0> translate<33.121600,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.434000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.484800,-1.535000,42.062400>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,-71.560328,0> translate<43.434000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.102800,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.688000,-1.535000,29.667200>}
box{<0,0,-0.152400><8.585200,0.035000,0.152400> rotate<0,0.000000,0> translate<35.102800,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.859200,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.891200,-1.535000,57.302400>}
box{<0,0,-0.152400><2.032000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.859200,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.827200,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.094400,-1.535000,23.977600>}
box{<0,0,-0.152400><4.267200,0.035000,0.152400> rotate<0,0.000000,0> translate<39.827200,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.891200,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.297600,-1.535000,57.302400>}
box{<0,0,-0.152400><0.406400,0.035000,0.152400> rotate<0,0.000000,0> translate<43.891200,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.891200,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,57.150000>}
box{<0,0,-0.152400><0.579209,0.035000,0.152400> rotate<0,15.254112,0> translate<43.891200,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.297600,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,57.150000>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,44.997030,0> translate<44.297600,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.500800,0.000000,57.099200>}
box{<0,0,-0.152400><0.071842,0.035000,0.152400> rotate<0,44.997030,0> translate<44.450000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.500800,0.000000,55.270400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.500800,0.000000,57.099200>}
box{<0,0,-0.152400><1.828800,0.035000,0.152400> rotate<0,90.000000,0> translate<44.500800,0.000000,57.099200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,0.000000,5.080000>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,0.000000,0> translate<43.281600,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,0.000000,5.207000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,90.000000,0> translate<45.720000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,7.747000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,13.970000>}
box{<0,0,-0.152400><6.223000,0.035000,0.152400> rotate<0,90.000000,0> translate<45.720000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,21.590000>}
box{<0,0,-0.152400><0.762000,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.720000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.094400,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,22.352000>}
box{<0,0,-0.152400><2.298946,0.035000,0.152400> rotate<0,44.997030,0> translate<44.094400,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.827200,0.000000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,0.000000,23.977600>}
box{<0,0,-0.152400><5.892800,0.035000,0.152400> rotate<0,0.000000,0> translate<39.827200,0.000000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,26.670000>}
box{<0,0,-0.152400><0.965200,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.720000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.688000,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,27.635200>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,44.997030,0> translate<43.688000,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.891200,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.329600,-1.535000,59.740800>}
box{<0,0,-0.152400><3.448418,0.035000,0.152400> rotate<0,-44.997030,0> translate<43.891200,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.484800,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.158400,0.000000,14.020800>}
box{<0,0,-0.152400><6.609469,0.035000,0.152400> rotate<0,44.997030,0> translate<43.484800,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,0.000000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.158400,0.000000,21.539200>}
box{<0,0,-0.152400><3.448418,0.035000,0.152400> rotate<0,44.997030,0> translate<45.720000,0.000000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.158400,0.000000,14.020800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,0.000000,13.970000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,26.563298,0> translate<48.158400,0.000000,14.020800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.158400,0.000000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,0.000000,21.590000>}
box{<0,0,-0.152400><0.113592,0.035000,0.152400> rotate<0,-26.563298,0> translate<48.158400,0.000000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,39.217600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.377600,-1.535000,39.217600>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.281600,-1.535000,39.217600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,44.297600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.377600,-1.535000,44.297600>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.281600,-1.535000,44.297600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.281600,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.377600,-1.535000,49.377600>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.281600,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.377600,-1.535000,39.217600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,-1.535000,39.370000>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.377600,-1.535000,39.217600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.377600,-1.535000,44.297600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,-1.535000,44.450000>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.377600,-1.535000,44.297600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.377600,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,-1.535000,49.530000>}
box{<0,0,-0.152400><0.215526,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.377600,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,2.641600>}
box{<0,0,-0.152400><0.204781,0.035000,0.152400> rotate<0,-29.742918,0> translate<49.403000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,2.641600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,5.080000>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,90.000000,0> translate<49.580800,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,7.518400>}
box{<0,0,-0.152400><0.204781,0.035000,0.152400> rotate<0,29.742918,0> translate<49.403000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,7.518400>}
box{<0,0,-0.152400><2.438400,0.035000,0.152400> rotate<0,90.000000,0> translate<49.580800,0.000000,7.518400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,-1.535000,7.721600>}
box{<0,0,-0.152400><0.204781,0.035000,0.152400> rotate<0,-29.742918,0> translate<49.403000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,-1.535000,39.420800>}
box{<0,0,-0.152400><0.071842,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.530000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,-1.535000,44.297600>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,71.560328,0> translate<49.530000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,49.377600>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,71.560328,0> translate<49.530000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<42.468800,-1.535000,54.457600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.580800,-1.535000,54.457600>}
box{<0,0,-0.406400><7.112000,0.035000,0.406400> rotate<0,0.000000,0> translate<42.468800,-1.535000,54.457600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.329600,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,-1.535000,59.740800>}
box{<0,0,-0.152400><3.251200,0.035000,0.152400> rotate<0,0.000000,0> translate<46.329600,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.657000,0.000000,5.080000>}
box{<0,0,-0.152400><0.076200,0.035000,0.152400> rotate<0,0.000000,0> translate<49.580800,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.784000,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.784000,-1.535000,41.910000>}
box{<0,0,-0.152400><0.152400,0.035000,0.152400> rotate<0,-90.000000,0> translate<49.784000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.484800,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.784000,-1.535000,42.062400>}
box{<0,0,-0.152400><6.299200,0.035000,0.152400> rotate<0,0.000000,0> translate<43.484800,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,0.000000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.987200,0.000000,31.292800>}
box{<0,0,-0.152400><7.315200,0.035000,0.152400> rotate<0,0.000000,0> translate<42.672000,0.000000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.580800,-1.535000,54.457600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.987200,-1.535000,54.051200>}
box{<0,0,-0.406400><0.574736,0.035000,0.406400> rotate<0,44.997030,0> translate<49.580800,-1.535000,54.457600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.500800,0.000000,55.270400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.393600,0.000000,49.377600>}
box{<0,0,-0.152400><8.333678,0.035000,0.152400> rotate<0,44.997030,0> translate<44.500800,0.000000,55.270400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.393600,0.000000,49.377600>}
box{<0,0,-0.152400><0.876944,0.035000,0.152400> rotate<0,10.007319,0> translate<49.530000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,0.000000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.393600,0.000000,49.377600>}
box{<0,0,-0.152400><0.812800,0.035000,0.152400> rotate<0,0.000000,0> translate<49.580800,0.000000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,0.000000,17.678400>}
box{<0,0,-0.152400><3.708400,0.035000,0.152400> rotate<0,90.000000,0> translate<50.800000,0.000000,17.678400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,26.670000>}
box{<0,0,-0.152400><4.419600,0.035000,0.152400> rotate<0,-90.000000,0> translate<50.800000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,58.420000>}
box{<0,0,-0.152400><0.101600,0.035000,0.152400> rotate<0,-90.000000,0> translate<50.800000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,58.521600>}
box{<0,0,-0.152400><1.724209,0.035000,0.152400> rotate<0,44.997030,0> translate<49.580800,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.987200,-1.535000,54.051200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.206400,-1.535000,54.051200>}
box{<0,0,-0.406400><1.219200,0.035000,0.406400> rotate<0,0.000000,0> translate<49.987200,-1.535000,54.051200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.265600,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.612800,0.000000,10.972800>}
box{<0,0,-0.152400><9.347200,0.035000,0.152400> rotate<0,0.000000,0> translate<42.265600,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.393600,0.000000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.222400,0.000000,47.548800>}
box{<0,0,-0.152400><2.586314,0.035000,0.152400> rotate<0,44.997030,0> translate<50.393600,0.000000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.222400,0.000000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.222400,0.000000,47.548800>}
box{<0,0,-0.152400><7.924800,0.035000,0.152400> rotate<0,90.000000,0> translate<52.222400,0.000000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628800,-1.535000,10.769600>}
box{<0,0,-0.152400><4.310523,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.580800,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628800,-1.535000,10.769600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628800,-1.535000,15.443200>}
box{<0,0,-0.152400><4.673600,0.035000,0.152400> rotate<0,90.000000,0> translate<52.628800,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628800,-1.535000,32.918400>}
box{<0,0,-0.152400><2.586314,0.035000,0.152400> rotate<0,-44.997030,0> translate<50.800000,-1.535000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628800,-1.535000,36.372800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628800,-1.535000,32.918400>}
box{<0,0,-0.152400><3.454400,0.035000,0.152400> rotate<0,-90.000000,0> translate<52.628800,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,-1.535000,39.420800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628800,-1.535000,36.372800>}
box{<0,0,-0.152400><4.310523,0.035000,0.152400> rotate<0,44.997030,0> translate<49.580800,-1.535000,39.420800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,0.000000,17.678400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.832000,0.000000,19.710400>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,-44.997030,0> translate<50.800000,0.000000,17.678400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.832000,0.000000,19.710400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.832000,0.000000,23.164800>}
box{<0,0,-0.152400><3.454400,0.035000,0.152400> rotate<0,90.000000,0> translate<52.832000,0.000000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.628800,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.832000,-1.535000,26.822400>}
box{<0,0,-0.406400><0.203200,0.035000,0.406400> rotate<0,0.000000,0> translate<52.628800,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.827200,-1.535000,16.459200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.238400,-1.535000,16.459200>}
box{<0,0,-0.152400><13.411200,0.035000,0.152400> rotate<0,0.000000,0> translate<39.827200,-1.535000,16.459200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.832000,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.238400,-1.535000,27.228800>}
box{<0,0,-0.406400><0.574736,0.035000,0.406400> rotate<0,-44.997030,0> translate<52.832000,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.238400,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.238400,-1.535000,29.870400>}
box{<0,0,-0.406400><2.641600,0.035000,0.406400> rotate<0,90.000000,0> translate<53.238400,-1.535000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.612800,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441600,0.000000,12.801600>}
box{<0,0,-0.152400><2.586314,0.035000,0.152400> rotate<0,-44.997030,0> translate<51.612800,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441600,0.000000,12.801600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441600,0.000000,14.833600>}
box{<0,0,-0.152400><2.032000,0.035000,0.152400> rotate<0,90.000000,0> translate<53.441600,0.000000,14.833600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628800,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441600,0.000000,16.256000>}
box{<0,0,-0.152400><1.149473,0.035000,0.152400> rotate<0,-44.997030,0> translate<52.628800,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441600,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441600,0.000000,22.148800>}
box{<0,0,-0.152400><5.892800,0.035000,0.152400> rotate<0,90.000000,0> translate<53.441600,0.000000,22.148800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.832000,0.000000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848000,0.000000,24.180800>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<52.832000,0.000000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.987200,0.000000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848000,0.000000,27.432000>}
box{<0,0,-0.152400><5.459996,0.035000,0.152400> rotate<0,44.997030,0> translate<49.987200,0.000000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848000,0.000000,24.180800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848000,0.000000,27.432000>}
box{<0,0,-0.152400><3.251200,0.035000,0.152400> rotate<0,90.000000,0> translate<53.848000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.848000,-1.535000,51.409600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.848000,-1.535000,51.003200>}
box{<0,0,-0.406400><0.406400,0.035000,0.406400> rotate<0,-90.000000,0> translate<53.848000,-1.535000,51.003200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.206400,-1.535000,54.051200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.848000,-1.535000,51.409600>}
box{<0,0,-0.406400><3.735787,0.035000,0.406400> rotate<0,44.997030,0> translate<51.206400,-1.535000,54.051200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441600,0.000000,22.148800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.457600,0.000000,23.164800>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<53.441600,0.000000,22.148800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.222400,0.000000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.457600,0.000000,37.388800>}
box{<0,0,-0.152400><3.161050,0.035000,0.152400> rotate<0,44.997030,0> translate<52.222400,0.000000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.457600,0.000000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.457600,0.000000,37.388800>}
box{<0,0,-0.152400><14.224000,0.035000,0.152400> rotate<0,90.000000,0> translate<54.457600,0.000000,37.388800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.848000,-1.535000,51.003200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.270400,-1.535000,49.580800>}
box{<0,0,-0.406400><2.011577,0.035000,0.406400> rotate<0,44.997030,0> translate<53.848000,-1.535000,51.003200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,8.890000>}
box{<0,0,-0.152400><4.927600,0.035000,0.152400> rotate<0,-90.000000,0> translate<55.880000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.238400,-1.535000,16.459200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,13.817600>}
box{<0,0,-0.152400><3.735787,0.035000,0.152400> rotate<0,44.997030,0> translate<53.238400,-1.535000,16.459200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,13.970000>}
box{<0,0,-0.152400><0.152400,0.035000,0.152400> rotate<0,90.000000,0> translate<55.880000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441600,0.000000,14.833600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,0.000000,17.272000>}
box{<0,0,-0.152400><3.448418,0.035000,0.152400> rotate<0,-44.997030,0> translate<53.441600,0.000000,14.833600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,0.000000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,0.000000,19.050000>}
box{<0,0,-0.152400><1.778000,0.035000,0.152400> rotate<0,90.000000,0> translate<55.880000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.070000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,20.320000>}
box{<0,0,-0.152400><5.388154,0.035000,0.152400> rotate<0,44.997030,0> translate<52.070000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,20.320000>}
box{<0,0,-0.152400><1.270000,0.035000,0.152400> rotate<0,90.000000,0> translate<55.880000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.580800,-1.535000,44.297600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,44.297600>}
box{<0,0,-0.152400><6.299200,0.035000,0.152400> rotate<0,0.000000,0> translate<49.580800,-1.535000,44.297600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,44.297600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.880000,-1.535000,44.450000>}
box{<0,0,-0.152400><0.152400,0.035000,0.152400> rotate<0,90.000000,0> translate<55.880000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.880000,-1.535000,49.580800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.880000,-1.535000,49.530000>}
box{<0,0,-0.406400><0.050800,0.035000,0.406400> rotate<0,-90.000000,0> translate<55.880000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.270400,-1.535000,49.580800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.880000,-1.535000,49.580800>}
box{<0,0,-0.406400><0.609600,0.035000,0.406400> rotate<0,0.000000,0> translate<55.270400,-1.535000,49.580800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.784000,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.083200,-1.535000,42.062400>}
box{<0,0,-0.152400><6.299200,0.035000,0.152400> rotate<0,0.000000,0> translate<49.784000,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.083200,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.134000,-1.535000,41.910000>}
box{<0,0,-0.152400><0.160644,0.035000,0.152400> rotate<0,71.560328,0> translate<56.083200,-1.535000,42.062400> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<-2.540000,0.000000,-1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<-2.540000,0.000000,62.230000>}
box{<0,0,-0.127000><63.500000,0.035000,0.127000> rotate<0,90.000000,0> translate<-2.540000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<-2.540000,0.000000,-1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,0.000000,-1.270000>}
box{<0,0,-0.127000><62.230000,0.035000,0.127000> rotate<0,0.000000,0> translate<-2.540000,0.000000,-1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<-2.540000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,0.000000,62.230000>}
box{<0,0,-0.127000><62.230000,0.035000,0.127000> rotate<0,0.000000,0> translate<-2.540000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<-1.270000,-1.535000,-1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<-1.270000,-1.535000,62.230000>}
box{<0,0,-0.127000><63.500000,0.035000,0.127000> rotate<0,90.000000,0> translate<-1.270000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<-1.270000,-1.535000,-1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,-1.270000>}
box{<0,0,-0.127000><60.960000,0.035000,0.127000> rotate<0,0.000000,0> translate<-1.270000,-1.535000,-1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<-1.270000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,62.230000>}
box{<0,0,-0.127000><60.960000,0.035000,0.127000> rotate<0,0.000000,0> translate<-1.270000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,0.000000,-1.270000>}
box{<0,0,-0.127000><63.500000,0.035000,0.127000> rotate<0,-90.000000,0> translate<59.690000,0.000000,-1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,-1.270000>}
box{<0,0,-0.127000><63.500000,0.035000,0.127000> rotate<0,-90.000000,0> translate<59.690000,-1.535000,-1.270000> }
texture{col_pol}
}
#end
union{
cylinder{<2.540000,0.038000,29.210000><2.540000,-1.538000,29.210000>0.400000}
cylinder{<2.540000,0.038000,31.750000><2.540000,-1.538000,31.750000>0.400000}
cylinder{<2.540000,0.038000,16.510000><2.540000,-1.538000,16.510000>0.400000}
cylinder{<2.540000,0.038000,19.050000><2.540000,-1.538000,19.050000>0.400000}
cylinder{<2.540000,0.038000,21.590000><2.540000,-1.538000,21.590000>0.400000}
cylinder{<2.540000,0.038000,24.130000><2.540000,-1.538000,24.130000>0.400000}
cylinder{<2.540000,0.038000,26.670000><2.540000,-1.538000,26.670000>0.400000}
cylinder{<15.240000,0.038000,46.990000><15.240000,-1.538000,46.990000>0.350000}
cylinder{<17.780000,0.038000,46.990000><17.780000,-1.538000,46.990000>0.350000}
cylinder{<24.130000,0.038000,48.260000><24.130000,-1.538000,48.260000>0.350000}
cylinder{<26.670000,0.038000,48.260000><26.670000,-1.538000,48.260000>0.350000}
cylinder{<29.210000,0.038000,43.180000><29.210000,-1.538000,43.180000>0.350000}
cylinder{<29.210000,0.038000,45.720000><29.210000,-1.538000,45.720000>0.350000}
cylinder{<50.800000,0.038000,58.420000><50.800000,-1.538000,58.420000>0.350000}
cylinder{<50.800000,0.038000,55.880000><50.800000,-1.538000,55.880000>0.350000}
cylinder{<49.530000,0.038000,24.130000><49.530000,-1.538000,24.130000>0.350000}
cylinder{<52.070000,0.038000,24.130000><52.070000,-1.538000,24.130000>0.350000}
cylinder{<53.340000,0.038000,8.890000><53.340000,-1.538000,8.890000>0.350000}
cylinder{<55.880000,0.038000,8.890000><55.880000,-1.538000,8.890000>0.350000}
cylinder{<44.450000,0.038000,57.150000><44.450000,-1.538000,57.150000>0.350000}
cylinder{<46.990000,0.038000,57.150000><46.990000,-1.538000,57.150000>0.350000}
cylinder{<36.830000,0.038000,11.430000><36.830000,-1.538000,11.430000>0.350000}
cylinder{<34.290000,0.038000,11.430000><34.290000,-1.538000,11.430000>0.350000}
cylinder{<25.400000,0.038000,31.750000><25.400000,-1.538000,31.750000>0.350000}
cylinder{<25.400000,0.038000,34.290000><25.400000,-1.538000,34.290000>0.350000}
cylinder{<10.160000,0.038000,36.830000><10.160000,-1.538000,36.830000>0.350000}
cylinder{<12.700000,0.038000,36.830000><12.700000,-1.538000,36.830000>0.350000}
cylinder{<10.160000,0.038000,25.400000><10.160000,-1.538000,25.400000>0.350000}
cylinder{<10.160000,0.038000,27.940000><10.160000,-1.538000,27.940000>0.350000}
cylinder{<13.970000,0.038000,19.050000><13.970000,-1.538000,19.050000>0.350000}
cylinder{<13.970000,0.038000,21.590000><13.970000,-1.538000,21.590000>0.350000}
cylinder{<15.240000,0.038000,50.800000><15.240000,-1.538000,50.800000>0.450000}
cylinder{<7.620000,0.038000,50.800000><7.620000,-1.538000,50.800000>0.450000}
cylinder{<36.830000,0.038000,39.370000><36.830000,-1.538000,39.370000>0.508000}
cylinder{<37.084000,0.038000,41.910000><37.084000,-1.538000,41.910000>0.508000}
cylinder{<36.830000,0.038000,44.450000><36.830000,-1.538000,44.450000>0.508000}
cylinder{<37.084000,0.038000,46.990000><37.084000,-1.538000,46.990000>0.508000}
cylinder{<36.830000,0.038000,49.530000><36.830000,-1.538000,49.530000>0.508000}
cylinder{<37.084000,0.038000,52.070000><37.084000,-1.538000,52.070000>0.508000}
cylinder{<43.180000,0.038000,39.370000><43.180000,-1.538000,39.370000>0.508000}
cylinder{<43.434000,0.038000,41.910000><43.434000,-1.538000,41.910000>0.508000}
cylinder{<43.180000,0.038000,44.450000><43.180000,-1.538000,44.450000>0.508000}
cylinder{<43.434000,0.038000,46.990000><43.434000,-1.538000,46.990000>0.508000}
cylinder{<43.180000,0.038000,49.530000><43.180000,-1.538000,49.530000>0.508000}
cylinder{<43.434000,0.038000,52.070000><43.434000,-1.538000,52.070000>0.508000}
cylinder{<49.530000,0.038000,39.370000><49.530000,-1.538000,39.370000>0.508000}
cylinder{<49.784000,0.038000,41.910000><49.784000,-1.538000,41.910000>0.508000}
cylinder{<49.530000,0.038000,44.450000><49.530000,-1.538000,44.450000>0.508000}
cylinder{<49.784000,0.038000,46.990000><49.784000,-1.538000,46.990000>0.508000}
cylinder{<49.530000,0.038000,49.530000><49.530000,-1.538000,49.530000>0.508000}
cylinder{<49.784000,0.038000,52.070000><49.784000,-1.538000,52.070000>0.508000}
cylinder{<55.880000,0.038000,39.370000><55.880000,-1.538000,39.370000>0.508000}
cylinder{<56.134000,0.038000,41.910000><56.134000,-1.538000,41.910000>0.508000}
cylinder{<55.880000,0.038000,44.450000><55.880000,-1.538000,44.450000>0.508000}
cylinder{<56.134000,0.038000,46.990000><56.134000,-1.538000,46.990000>0.508000}
cylinder{<55.880000,0.038000,49.530000><55.880000,-1.538000,49.530000>0.508000}
cylinder{<56.134000,0.038000,52.070000><56.134000,-1.538000,52.070000>0.508000}
cylinder{<24.130000,0.038000,54.610000><24.130000,-1.538000,54.610000>0.508000}
cylinder{<26.670000,0.038000,54.610000><26.670000,-1.538000,54.610000>0.508000}
cylinder{<29.210000,0.038000,54.610000><29.210000,-1.538000,54.610000>0.508000}
cylinder{<39.370000,0.038000,54.991000><39.370000,-1.538000,54.991000>0.406400}
cylinder{<39.370000,0.038000,57.150000><39.370000,-1.538000,57.150000>0.406400}
cylinder{<39.370000,0.038000,59.309000><39.370000,-1.538000,59.309000>0.406400}
cylinder{<17.780000,0.038000,13.970000><17.780000,-1.538000,13.970000>0.406400}
cylinder{<20.320000,0.038000,13.970000><20.320000,-1.538000,13.970000>0.406400}
cylinder{<22.860000,0.038000,13.970000><22.860000,-1.538000,13.970000>0.406400}
cylinder{<25.400000,0.038000,13.970000><25.400000,-1.538000,13.970000>0.406400}
cylinder{<27.940000,0.038000,13.970000><27.940000,-1.538000,13.970000>0.406400}
cylinder{<30.480000,0.038000,13.970000><30.480000,-1.538000,13.970000>0.406400}
cylinder{<33.020000,0.038000,13.970000><33.020000,-1.538000,13.970000>0.406400}
cylinder{<35.560000,0.038000,13.970000><35.560000,-1.538000,13.970000>0.406400}
cylinder{<38.100000,0.038000,13.970000><38.100000,-1.538000,13.970000>0.406400}
cylinder{<40.640000,0.038000,13.970000><40.640000,-1.538000,13.970000>0.406400}
cylinder{<43.180000,0.038000,13.970000><43.180000,-1.538000,13.970000>0.406400}
cylinder{<45.720000,0.038000,13.970000><45.720000,-1.538000,13.970000>0.406400}
cylinder{<48.260000,0.038000,13.970000><48.260000,-1.538000,13.970000>0.406400}
cylinder{<50.800000,0.038000,13.970000><50.800000,-1.538000,13.970000>0.406400}
cylinder{<50.800000,0.038000,21.590000><50.800000,-1.538000,21.590000>0.406400}
cylinder{<48.260000,0.038000,21.590000><48.260000,-1.538000,21.590000>0.406400}
cylinder{<45.720000,0.038000,21.590000><45.720000,-1.538000,21.590000>0.406400}
cylinder{<43.180000,0.038000,21.590000><43.180000,-1.538000,21.590000>0.406400}
cylinder{<40.640000,0.038000,21.590000><40.640000,-1.538000,21.590000>0.406400}
cylinder{<38.100000,0.038000,21.590000><38.100000,-1.538000,21.590000>0.406400}
cylinder{<35.560000,0.038000,21.590000><35.560000,-1.538000,21.590000>0.406400}
cylinder{<33.020000,0.038000,21.590000><33.020000,-1.538000,21.590000>0.406400}
cylinder{<30.480000,0.038000,21.590000><30.480000,-1.538000,21.590000>0.406400}
cylinder{<27.940000,0.038000,21.590000><27.940000,-1.538000,21.590000>0.406400}
cylinder{<25.400000,0.038000,21.590000><25.400000,-1.538000,21.590000>0.406400}
cylinder{<22.860000,0.038000,21.590000><22.860000,-1.538000,21.590000>0.406400}
cylinder{<20.320000,0.038000,21.590000><20.320000,-1.538000,21.590000>0.406400}
cylinder{<17.780000,0.038000,21.590000><17.780000,-1.538000,21.590000>0.406400}
cylinder{<13.970000,0.038000,25.400000><13.970000,-1.538000,25.400000>0.406400}
cylinder{<16.510000,0.038000,25.400000><16.510000,-1.538000,25.400000>0.406400}
cylinder{<19.050000,0.038000,25.400000><19.050000,-1.538000,25.400000>0.406400}
cylinder{<21.590000,0.038000,25.400000><21.590000,-1.538000,25.400000>0.406400}
cylinder{<21.590000,0.038000,33.020000><21.590000,-1.538000,33.020000>0.406400}
cylinder{<19.050000,0.038000,33.020000><19.050000,-1.538000,33.020000>0.406400}
cylinder{<16.510000,0.038000,33.020000><16.510000,-1.538000,33.020000>0.406400}
cylinder{<13.970000,0.038000,33.020000><13.970000,-1.538000,33.020000>0.406400}
cylinder{<17.907000,0.038000,57.150000><17.907000,-1.538000,57.150000>0.508000}
cylinder{<15.113000,0.038000,57.150000><15.113000,-1.538000,57.150000>0.508000}
cylinder{<11.557000,0.038000,57.150000><11.557000,-1.538000,57.150000>0.508000}
cylinder{<8.763000,0.038000,57.150000><8.763000,-1.538000,57.150000>0.508000}
cylinder{<2.540000,0.038000,49.530000><2.540000,-1.538000,49.530000>0.508000}
cylinder{<2.540000,0.038000,46.990000><2.540000,-1.538000,46.990000>0.508000}
cylinder{<19.050000,0.038000,6.350000><19.050000,-1.538000,6.350000>0.508000}
cylinder{<8.890000,0.038000,6.350000><8.890000,-1.538000,6.350000>0.508000}
cylinder{<21.590000,0.038000,6.350000><21.590000,-1.538000,6.350000>0.508000}
cylinder{<11.430000,0.038000,6.350000><11.430000,-1.538000,6.350000>0.508000}
cylinder{<13.970000,0.038000,6.350000><13.970000,-1.538000,6.350000>0.508000}
cylinder{<16.510000,0.038000,6.350000><16.510000,-1.538000,6.350000>0.508000}
cylinder{<3.810000,0.038000,35.560000><3.810000,-1.538000,35.560000>0.508000}
cylinder{<3.810000,0.038000,38.354000><3.810000,-1.538000,38.354000>0.508000}
cylinder{<25.400000,0.038000,2.667000><25.400000,-1.538000,2.667000>0.508000}
cylinder{<27.940000,0.038000,2.413000><27.940000,-1.538000,2.413000>0.508000}
cylinder{<30.480000,0.038000,2.667000><30.480000,-1.538000,2.667000>0.508000}
cylinder{<33.020000,0.038000,2.413000><33.020000,-1.538000,2.413000>0.508000}
cylinder{<35.560000,0.038000,2.667000><35.560000,-1.538000,2.667000>0.508000}
cylinder{<38.100000,0.038000,2.413000><38.100000,-1.538000,2.413000>0.508000}
cylinder{<40.640000,0.038000,2.667000><40.640000,-1.538000,2.667000>0.508000}
cylinder{<43.180000,0.038000,2.413000><43.180000,-1.538000,2.413000>0.508000}
cylinder{<45.720000,0.038000,2.667000><45.720000,-1.538000,2.667000>0.508000}
cylinder{<25.400000,0.038000,5.207000><25.400000,-1.538000,5.207000>0.508000}
cylinder{<27.940000,0.038000,4.953000><27.940000,-1.538000,4.953000>0.508000}
cylinder{<30.480000,0.038000,5.207000><30.480000,-1.538000,5.207000>0.508000}
cylinder{<33.020000,0.038000,4.953000><33.020000,-1.538000,4.953000>0.508000}
cylinder{<35.560000,0.038000,5.207000><35.560000,-1.538000,5.207000>0.508000}
cylinder{<38.100000,0.038000,4.953000><38.100000,-1.538000,4.953000>0.508000}
cylinder{<40.640000,0.038000,5.207000><40.640000,-1.538000,5.207000>0.508000}
cylinder{<43.180000,0.038000,4.953000><43.180000,-1.538000,4.953000>0.508000}
cylinder{<45.720000,0.038000,5.207000><45.720000,-1.538000,5.207000>0.508000}
cylinder{<35.560000,0.038000,7.747000><35.560000,-1.538000,7.747000>0.508000}
cylinder{<38.100000,0.038000,7.493000><38.100000,-1.538000,7.493000>0.508000}
cylinder{<40.640000,0.038000,7.747000><40.640000,-1.538000,7.747000>0.508000}
cylinder{<43.180000,0.038000,7.493000><43.180000,-1.538000,7.493000>0.508000}
cylinder{<45.720000,0.038000,7.747000><45.720000,-1.538000,7.747000>0.508000}
cylinder{<49.403000,0.038000,2.540000><49.403000,-1.538000,2.540000>0.508000}
cylinder{<49.657000,0.038000,5.080000><49.657000,-1.538000,5.080000>0.508000}
cylinder{<49.403000,0.038000,7.620000><49.403000,-1.538000,7.620000>0.508000}
cylinder{<33.020000,0.038000,7.493000><33.020000,-1.538000,7.493000>0.508000}
cylinder{<30.480000,0.038000,7.747000><30.480000,-1.538000,7.747000>0.508000}
cylinder{<27.940000,0.038000,7.493000><27.940000,-1.538000,7.493000>0.508000}
cylinder{<25.400000,0.038000,7.747000><25.400000,-1.538000,7.747000>0.508000}
cylinder{<8.890000,0.038000,48.260000><8.890000,-1.538000,48.260000>0.406400}
cylinder{<8.890000,0.038000,45.720000><8.890000,-1.538000,45.720000>0.406400}
cylinder{<2.540000,0.038000,41.910000><2.540000,-1.538000,41.910000>0.450000}
cylinder{<12.700000,0.038000,41.910000><12.700000,-1.538000,41.910000>0.450000}
cylinder{<12.700000,0.038000,10.160000><12.700000,-1.538000,10.160000>0.450000}
cylinder{<20.320000,0.038000,10.160000><20.320000,-1.538000,10.160000>0.450000}
cylinder{<26.670000,0.038000,41.910000><26.670000,-1.538000,41.910000>0.450000}
cylinder{<16.510000,0.038000,41.910000><16.510000,-1.538000,41.910000>0.450000}
cylinder{<3.098800,0.038000,13.690600><3.098800,-1.538000,13.690600>0.508000}
cylinder{<9.601200,0.038000,13.690600><9.601200,-1.538000,13.690600>0.508000}
cylinder{<3.098800,0.038000,9.169400><3.098800,-1.538000,9.169400>0.508000}
cylinder{<9.601200,0.038000,9.169400><9.601200,-1.538000,9.169400>0.508000}
cylinder{<57.023000,0.038000,24.130000><57.023000,-1.538000,24.130000>0.508000}
cylinder{<57.277000,0.038000,26.670000><57.277000,-1.538000,26.670000>0.508000}
cylinder{<57.023000,0.038000,29.210000><57.023000,-1.538000,29.210000>0.508000}
cylinder{<57.277000,0.038000,31.750000><57.277000,-1.538000,31.750000>0.508000}
cylinder{<27.940000,0.038000,26.670000><27.940000,-1.538000,26.670000>0.406400}
cylinder{<30.480000,0.038000,26.670000><30.480000,-1.538000,26.670000>0.406400}
cylinder{<33.020000,0.038000,26.670000><33.020000,-1.538000,26.670000>0.406400}
cylinder{<35.560000,0.038000,26.670000><35.560000,-1.538000,26.670000>0.406400}
cylinder{<38.100000,0.038000,26.670000><38.100000,-1.538000,26.670000>0.406400}
cylinder{<40.640000,0.038000,26.670000><40.640000,-1.538000,26.670000>0.406400}
cylinder{<43.180000,0.038000,26.670000><43.180000,-1.538000,26.670000>0.406400}
cylinder{<45.720000,0.038000,26.670000><45.720000,-1.538000,26.670000>0.406400}
cylinder{<48.260000,0.038000,26.670000><48.260000,-1.538000,26.670000>0.406400}
cylinder{<50.800000,0.038000,26.670000><50.800000,-1.538000,26.670000>0.406400}
cylinder{<50.800000,0.038000,34.290000><50.800000,-1.538000,34.290000>0.406400}
cylinder{<48.260000,0.038000,34.290000><48.260000,-1.538000,34.290000>0.406400}
cylinder{<45.720000,0.038000,34.290000><45.720000,-1.538000,34.290000>0.406400}
cylinder{<43.180000,0.038000,34.290000><43.180000,-1.538000,34.290000>0.406400}
cylinder{<40.640000,0.038000,34.290000><40.640000,-1.538000,34.290000>0.406400}
cylinder{<38.100000,0.038000,34.290000><38.100000,-1.538000,34.290000>0.406400}
cylinder{<35.560000,0.038000,34.290000><35.560000,-1.538000,34.290000>0.406400}
cylinder{<33.020000,0.038000,34.290000><33.020000,-1.538000,34.290000>0.406400}
cylinder{<30.480000,0.038000,34.290000><30.480000,-1.538000,34.290000>0.406400}
cylinder{<27.940000,0.038000,34.290000><27.940000,-1.538000,34.290000>0.406400}
cylinder{<55.880000,0.038000,13.970000><55.880000,-1.538000,13.970000>0.350000}
cylinder{<55.880000,0.038000,19.050000><55.880000,-1.538000,19.050000>0.350000}
//Holes(fast)/Vias
cylinder{<30.480000,0.038000,17.678400><30.480000,-1.538000,17.678400>0.254000 }
cylinder{<27.838400,0.038000,16.256000><27.838400,-1.538000,16.256000>0.254000 }
cylinder{<25.400000,0.038000,16.256000><25.400000,-1.538000,16.256000>0.254000 }
cylinder{<38.201600,0.038000,16.256000><38.201600,-1.538000,16.256000>0.254000 }
cylinder{<35.356800,0.038000,9.956800><35.356800,-1.538000,9.956800>0.254000 }
cylinder{<6.502400,0.038000,14.020800><6.502400,-1.538000,14.020800>0.254000 }
cylinder{<52.628800,0.038000,26.822400><52.628800,-1.538000,26.822400>0.254000 }
cylinder{<53.238400,0.038000,29.870400><53.238400,-1.538000,29.870400>0.254000 }
cylinder{<35.102800,0.038000,29.667200><35.102800,-1.538000,29.667200>0.254000 }
cylinder{<27.051000,0.038000,29.718000><27.051000,-1.538000,29.718000>0.254000 }
cylinder{<30.226000,0.038000,29.718000><30.226000,-1.538000,29.718000>0.254000 }
cylinder{<33.121600,0.038000,18.694400><33.121600,-1.538000,18.694400>0.254000 }
cylinder{<43.484800,0.038000,18.694400><43.484800,-1.538000,18.694400>0.254000 }
cylinder{<7.721600,0.038000,19.710400><7.721600,-1.538000,19.710400>0.254000 }
cylinder{<30.632400,0.038000,38.049200><30.632400,-1.538000,38.049200>0.254000 }
cylinder{<41.046400,0.038000,56.692800><41.046400,-1.538000,56.692800>0.254000 }
cylinder{<42.672000,0.038000,58.318400><42.672000,-1.538000,58.318400>0.254000 }
cylinder{<52.628800,0.038000,15.443200><52.628800,-1.538000,15.443200>0.254000 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.904000,0.000000,35.886400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,35.750800>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-45.018163,0> translate<6.768500,0.000000,35.750800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,35.750800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,35.479600>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,-90.000000,0> translate<6.768500,0.000000,35.479600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,35.479600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.904000,0.000000,35.344100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<6.768500,0.000000,35.479600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.904000,0.000000,35.344100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.039600,0.000000,35.344100>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,0.000000,0> translate<6.904000,0.000000,35.344100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.039600,0.000000,35.344100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,35.479600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<7.039600,0.000000,35.344100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,35.479600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,35.750800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,90.000000,0> translate<7.175200,0.000000,35.750800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,35.750800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,35.886400>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,-44.997030,0> translate<7.175200,0.000000,35.750800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,35.886400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.446400,0.000000,35.886400>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,0.000000,0> translate<7.310800,0.000000,35.886400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.446400,0.000000,35.886400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,35.750800>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,45.018163,0> translate<7.446400,0.000000,35.886400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,35.750800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,35.479600>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,-90.000000,0> translate<7.581900,0.000000,35.479600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,35.479600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.446400,0.000000,35.344100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<7.446400,0.000000,35.344100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,36.162600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,36.162600>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,0.000000,0> translate<6.768500,0.000000,36.162600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,36.162600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,36.569300>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,90.000000,0> translate<6.768500,0.000000,36.569300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,36.569300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.904000,0.000000,36.704900>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-45.018163,0> translate<6.768500,0.000000,36.569300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.904000,0.000000,36.704900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,36.704900>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<6.904000,0.000000,36.704900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,36.704900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,36.569300>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<7.175200,0.000000,36.704900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,36.569300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,36.162600>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,-90.000000,0> translate<7.310800,0.000000,36.162600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,36.981100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,36.981100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,0.000000,0> translate<6.768500,0.000000,36.981100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,36.981100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,37.523400>}
box{<0,0,-0.038100><0.766928,0.036000,0.038100> rotate<0,44.997030,0> translate<6.768500,0.000000,37.523400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,37.116600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,37.523400>}
box{<0,0,-0.038100><0.575231,0.036000,0.038100> rotate<0,-45.004073,0> translate<7.175200,0.000000,37.116600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,37.799600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,37.799600>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,0.000000,0> translate<6.768500,0.000000,37.799600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,37.799600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,38.206300>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,90.000000,0> translate<6.768500,0.000000,38.206300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.768500,0.000000,38.206300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.904000,0.000000,38.341900>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-45.018163,0> translate<6.768500,0.000000,38.206300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.904000,0.000000,38.341900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,38.341900>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<6.904000,0.000000,38.341900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.175200,0.000000,38.341900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,38.206300>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<7.175200,0.000000,38.341900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,38.206300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,37.799600>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,-90.000000,0> translate<7.310800,0.000000,37.799600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.310800,0.000000,38.070700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,38.341900>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,-45.007595,0> translate<7.310800,0.000000,38.070700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,41.737000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,41.872500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<31.009100,0.000000,41.872500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,41.872500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,41.872500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.737900,0.000000,41.872500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,41.872500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,41.737000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<30.602400,0.000000,41.737000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,41.737000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,41.601400>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.602400,0.000000,41.601400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,41.601400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,41.465800>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,45.018163,0> translate<30.602400,0.000000,41.601400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,41.465800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,41.465800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.737900,0.000000,41.465800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,41.465800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,41.330200>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<31.009100,0.000000,41.465800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,41.330200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,41.194600>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<31.144700,0.000000,41.194600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,41.194600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,41.059100>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<31.009100,0.000000,41.059100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,41.059100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,41.059100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.737900,0.000000,41.059100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,41.059100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,41.194600>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<30.602400,0.000000,41.194600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,41.872500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,41.059100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<31.420900,0.000000,41.059100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,41.059100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,41.059100>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<31.420900,0.000000,41.059100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,41.059100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,41.194600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<31.827600,0.000000,41.059100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,41.194600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,41.737000>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,90.000000,0> translate<31.963200,0.000000,41.737000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,41.737000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,41.872500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<31.827600,0.000000,41.872500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,41.872500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,41.872500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<31.420900,0.000000,41.872500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,41.059100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,41.601400>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<32.239400,0.000000,41.601400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,41.601400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.510500,0.000000,41.872500>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<32.239400,0.000000,41.601400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.510500,0.000000,41.872500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,41.601400>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,44.986466,0> translate<32.510500,0.000000,41.872500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,41.601400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,41.059100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<32.781700,0.000000,41.059100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,41.465800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,41.465800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<32.239400,0.000000,41.465800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,44.277000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,44.412500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<31.009100,0.000000,44.412500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,44.412500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,44.412500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.737900,0.000000,44.412500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,44.412500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,44.277000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<30.602400,0.000000,44.277000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,44.277000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,44.141400>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.602400,0.000000,44.141400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,44.141400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,44.005800>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,45.018163,0> translate<30.602400,0.000000,44.141400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,44.005800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,44.005800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.737900,0.000000,44.005800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,44.005800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,43.870200>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<31.009100,0.000000,44.005800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,43.870200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,43.734600>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<31.144700,0.000000,43.734600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,43.734600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,43.599100>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<31.009100,0.000000,43.599100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,43.599100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,43.599100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.737900,0.000000,43.599100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,43.599100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,43.734600>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<30.602400,0.000000,43.734600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,44.277000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,44.412500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<31.827600,0.000000,44.412500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,44.412500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.556400,0.000000,44.412500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.556400,0.000000,44.412500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.556400,0.000000,44.412500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,44.277000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<31.420900,0.000000,44.277000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,44.277000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,43.734600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<31.420900,0.000000,43.734600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,43.734600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.556400,0.000000,43.599100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<31.420900,0.000000,43.734600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.556400,0.000000,43.599100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,43.599100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.556400,0.000000,43.599100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,43.599100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,43.734600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<31.827600,0.000000,43.599100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,44.412500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,43.599100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<32.239400,0.000000,43.599100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,43.599100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,43.599100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<32.239400,0.000000,43.599100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.219300,0.000000,48.984500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.219300,0.000000,48.442200>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<29.219300,0.000000,48.442200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.219300,0.000000,48.442200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.490400,0.000000,48.171100>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<29.219300,0.000000,48.442200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.490400,0.000000,48.171100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.761600,0.000000,48.442200>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,-44.986466,0> translate<29.490400,0.000000,48.171100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.761600,0.000000,48.442200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.761600,0.000000,48.984500>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<29.761600,0.000000,48.984500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.580100,0.000000,48.849000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.444500,0.000000,48.984500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<30.444500,0.000000,48.984500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.444500,0.000000,48.984500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.173300,0.000000,48.984500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.173300,0.000000,48.984500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.173300,0.000000,48.984500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.037800,0.000000,48.849000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<30.037800,0.000000,48.849000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.037800,0.000000,48.849000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.037800,0.000000,48.306600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.037800,0.000000,48.306600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.037800,0.000000,48.306600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.173300,0.000000,48.171100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<30.037800,0.000000,48.306600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.173300,0.000000,48.171100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.444500,0.000000,48.171100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.173300,0.000000,48.171100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.444500,0.000000,48.171100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.580100,0.000000,48.306600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<30.444500,0.000000,48.171100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.398600,0.000000,48.849000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.263000,0.000000,48.984500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<31.263000,0.000000,48.984500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.263000,0.000000,48.984500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.991800,0.000000,48.984500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.991800,0.000000,48.984500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.991800,0.000000,48.984500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.856300,0.000000,48.849000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<30.856300,0.000000,48.849000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.856300,0.000000,48.849000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.856300,0.000000,48.306600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.856300,0.000000,48.306600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.856300,0.000000,48.306600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.991800,0.000000,48.171100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<30.856300,0.000000,48.306600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.991800,0.000000,48.171100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.263000,0.000000,48.171100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.991800,0.000000,48.171100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.263000,0.000000,48.171100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.398600,0.000000,48.306600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<31.263000,0.000000,48.171100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.674800,0.000000,48.171100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.217100,0.000000,48.984500>}
box{<0,0,-0.038100><0.977604,0.036000,0.038100> rotate<0,-56.304591,0> translate<31.674800,0.000000,48.171100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.035600,0.000000,48.171100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.493300,0.000000,48.171100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<32.493300,0.000000,48.171100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.493300,0.000000,48.171100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.035600,0.000000,48.713400>}
box{<0,0,-0.038100><0.766928,0.036000,0.038100> rotate<0,-44.997030,0> translate<32.493300,0.000000,48.171100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.035600,0.000000,48.713400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.035600,0.000000,48.849000>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,90.000000,0> translate<33.035600,0.000000,48.849000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.035600,0.000000,48.849000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.900000,0.000000,48.984500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<32.900000,0.000000,48.984500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.900000,0.000000,48.984500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.628800,0.000000,48.984500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<32.628800,0.000000,48.984500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.628800,0.000000,48.984500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.493300,0.000000,48.849000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<32.493300,0.000000,48.849000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.056700,0.000000,39.332500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.056700,0.000000,38.519100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.056700,0.000000,38.519100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.056700,0.000000,38.519100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.599000,0.000000,38.519100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<30.056700,0.000000,38.519100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.875200,0.000000,38.519100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.146300,0.000000,38.519100>}
box{<0,0,-0.038100><0.271100,0.036000,0.038100> rotate<0,0.000000,0> translate<30.875200,0.000000,38.519100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.010700,0.000000,38.519100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.010700,0.000000,39.332500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<31.010700,0.000000,39.332500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.875200,0.000000,39.332500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.146300,0.000000,39.332500>}
box{<0,0,-0.038100><0.271100,0.036000,0.038100> rotate<0,0.000000,0> translate<30.875200,0.000000,39.332500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,38.519100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,39.332500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<31.420900,0.000000,39.332500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,39.332500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,38.519100>}
box{<0,0,-0.038100><0.977604,0.036000,0.038100> rotate<0,56.304591,0> translate<31.420900,0.000000,39.332500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,38.519100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,39.332500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<31.963200,0.000000,39.332500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,39.332500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,39.332500>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<32.239400,0.000000,39.332500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,39.332500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,38.519100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<32.239400,0.000000,38.519100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,38.519100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,38.519100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<32.239400,0.000000,38.519100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,38.925800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.510500,0.000000,38.925800>}
box{<0,0,-0.038100><0.271100,0.036000,0.038100> rotate<0,0.000000,0> translate<32.239400,0.000000,38.925800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,52.032500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,51.490200>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.602400,0.000000,51.490200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,51.490200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.873500,0.000000,51.219100>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<30.602400,0.000000,51.490200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.873500,0.000000,51.219100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,51.490200>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,-44.986466,0> translate<30.873500,0.000000,51.219100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,51.490200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,52.032500>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<31.144700,0.000000,52.032500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,51.897000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,52.032500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<31.827600,0.000000,52.032500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,52.032500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.556400,0.000000,52.032500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.556400,0.000000,52.032500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.556400,0.000000,52.032500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,51.897000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<31.420900,0.000000,51.897000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,51.897000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,51.354600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<31.420900,0.000000,51.354600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,51.354600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.556400,0.000000,51.219100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<31.420900,0.000000,51.354600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.556400,0.000000,51.219100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,51.219100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.556400,0.000000,51.219100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.827600,0.000000,51.219100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,51.354600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<31.827600,0.000000,51.219100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,51.897000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.646100,0.000000,52.032500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<32.646100,0.000000,52.032500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.646100,0.000000,52.032500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.374900,0.000000,52.032500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<32.374900,0.000000,52.032500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.374900,0.000000,52.032500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,51.897000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<32.239400,0.000000,51.897000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,51.897000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,51.354600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<32.239400,0.000000,51.354600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,51.354600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.374900,0.000000,51.219100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<32.239400,0.000000,51.354600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.374900,0.000000,51.219100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.646100,0.000000,51.219100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<32.374900,0.000000,51.219100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.646100,0.000000,51.219100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,51.354600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<32.646100,0.000000,51.219100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,46.817000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,46.952500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<31.009100,0.000000,46.952500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,46.952500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,46.952500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.737900,0.000000,46.952500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,46.952500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,46.817000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<30.602400,0.000000,46.817000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,46.817000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,46.274600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.602400,0.000000,46.274600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.602400,0.000000,46.274600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,46.139100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<30.602400,0.000000,46.274600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.737900,0.000000,46.139100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,46.139100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.737900,0.000000,46.139100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.009100,0.000000,46.139100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,46.274600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<31.009100,0.000000,46.139100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,46.274600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,46.545800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,90.000000,0> translate<31.144700,0.000000,46.545800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.144700,0.000000,46.545800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.873500,0.000000,46.545800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<30.873500,0.000000,46.545800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,46.139100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,46.952500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<31.420900,0.000000,46.952500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.420900,0.000000,46.952500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,46.139100>}
box{<0,0,-0.038100><0.977604,0.036000,0.038100> rotate<0,56.304591,0> translate<31.420900,0.000000,46.952500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,46.139100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.963200,0.000000,46.952500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<31.963200,0.000000,46.952500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,46.952500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,46.139100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<32.239400,0.000000,46.139100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,46.139100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.646100,0.000000,46.139100>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<32.239400,0.000000,46.139100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.646100,0.000000,46.139100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,46.274600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<32.646100,0.000000,46.139100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,46.274600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,46.817000>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,90.000000,0> translate<32.781700,0.000000,46.817000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.781700,0.000000,46.817000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.646100,0.000000,46.952500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<32.646100,0.000000,46.952500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.646100,0.000000,46.952500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.239400,0.000000,46.952500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<32.239400,0.000000,46.952500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.411700,0.000000,0.716000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.276100,0.000000,0.851500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<8.276100,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.276100,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.004900,0.000000,0.851500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<8.004900,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.004900,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.869400,0.000000,0.716000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<7.869400,0.000000,0.716000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.869400,0.000000,0.716000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.869400,0.000000,0.173600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<7.869400,0.000000,0.173600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.869400,0.000000,0.173600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.004900,0.000000,0.038100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<7.869400,0.000000,0.173600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.004900,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.276100,0.000000,0.038100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<8.004900,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.276100,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.411700,0.000000,0.173600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<8.276100,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.411700,0.000000,0.173600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.411700,0.000000,0.444800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,90.000000,0> translate<8.411700,0.000000,0.444800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.411700,0.000000,0.444800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.140500,0.000000,0.444800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<8.140500,0.000000,0.444800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.687900,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.687900,0.000000,0.851500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<8.687900,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.687900,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.094600,0.000000,0.851500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<8.687900,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.094600,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.230200,0.000000,0.716000>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<9.094600,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.230200,0.000000,0.716000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.230200,0.000000,0.444800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,-90.000000,0> translate<9.230200,0.000000,0.444800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.230200,0.000000,0.444800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.094600,0.000000,0.309200>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,-44.997030,0> translate<9.094600,0.000000,0.309200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.094600,0.000000,0.309200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.687900,0.000000,0.309200>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<8.687900,0.000000,0.309200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<8.959000,0.000000,0.309200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.230200,0.000000,0.038100>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,44.986466,0> translate<8.959000,0.000000,0.309200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.506400,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.506400,0.000000,0.851500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<9.506400,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.506400,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.048700,0.000000,0.038100>}
box{<0,0,-0.038100><0.977604,0.036000,0.038100> rotate<0,56.304591,0> translate<9.506400,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.048700,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.048700,0.000000,0.851500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<10.048700,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.569400,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.569400,0.000000,0.851500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<20.569400,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.569400,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.976100,0.000000,0.851500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<20.569400,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.976100,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.111700,0.000000,0.716000>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<20.976100,0.000000,0.851500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.111700,0.000000,0.716000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.111700,0.000000,0.580400>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<21.111700,0.000000,0.580400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.111700,0.000000,0.580400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.976100,0.000000,0.444800>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,-44.997030,0> translate<20.976100,0.000000,0.444800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.976100,0.000000,0.444800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.111700,0.000000,0.309200>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<20.976100,0.000000,0.444800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.111700,0.000000,0.309200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.111700,0.000000,0.173600>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<21.111700,0.000000,0.173600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.111700,0.000000,0.173600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.976100,0.000000,0.038100>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<20.976100,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.976100,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.569400,0.000000,0.038100>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<20.569400,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.569400,0.000000,0.444800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.976100,0.000000,0.444800>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<20.569400,0.000000,0.444800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.387900,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.387900,0.000000,0.038100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<21.387900,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.387900,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.930200,0.000000,0.038100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<21.387900,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.206400,0.000000,0.851500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.206400,0.000000,0.038100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<22.206400,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.206400,0.000000,0.309200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.748700,0.000000,0.851500>}
box{<0,0,-0.038100><0.766928,0.036000,0.038100> rotate<0,-44.997030,0> translate<22.206400,0.000000,0.309200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.341900,0.000000,0.444800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.748700,0.000000,0.038100>}
box{<0,0,-0.038100><0.575231,0.036000,0.038100> rotate<0,44.989988,0> translate<22.341900,0.000000,0.444800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.101000,0.000000,53.302500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.101000,0.000000,52.760200>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<11.101000,0.000000,52.760200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.101000,0.000000,52.760200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.372100,0.000000,52.489100>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<11.101000,0.000000,52.760200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.372100,0.000000,52.489100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.643300,0.000000,52.760200>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,-44.986466,0> translate<11.372100,0.000000,52.489100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.643300,0.000000,52.760200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.643300,0.000000,53.302500>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<11.643300,0.000000,53.302500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.919500,0.000000,52.895800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.461800,0.000000,52.895800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<11.919500,0.000000,52.895800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.190600,0.000000,53.167000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.190600,0.000000,52.624600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.190600,0.000000,52.624600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.632400,0.000000,53.302500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.632400,0.000000,52.760200>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<16.632400,0.000000,52.760200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.632400,0.000000,52.760200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.903500,0.000000,52.489100>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<16.632400,0.000000,52.760200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.903500,0.000000,52.489100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.174700,0.000000,52.760200>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,-44.986466,0> translate<16.903500,0.000000,52.489100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.174700,0.000000,52.760200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.174700,0.000000,53.302500>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<17.174700,0.000000,53.302500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.993200,0.000000,53.167000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.857600,0.000000,53.302500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<17.857600,0.000000,53.302500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.857600,0.000000,53.302500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.586400,0.000000,53.302500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<17.586400,0.000000,53.302500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.586400,0.000000,53.302500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.450900,0.000000,53.167000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<17.450900,0.000000,53.167000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.450900,0.000000,53.167000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.450900,0.000000,52.624600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<17.450900,0.000000,52.624600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.450900,0.000000,52.624600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.586400,0.000000,52.489100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<17.450900,0.000000,52.624600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.586400,0.000000,52.489100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.857600,0.000000,52.489100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<17.586400,0.000000,52.489100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.857600,0.000000,52.489100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.993200,0.000000,52.624600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<17.857600,0.000000,52.489100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.811700,0.000000,53.167000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.676100,0.000000,53.302500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<18.676100,0.000000,53.302500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.676100,0.000000,53.302500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.404900,0.000000,53.302500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<18.404900,0.000000,53.302500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.404900,0.000000,53.302500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.269400,0.000000,53.167000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<18.269400,0.000000,53.167000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.269400,0.000000,53.167000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.269400,0.000000,52.624600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<18.269400,0.000000,52.624600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.269400,0.000000,52.624600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.404900,0.000000,52.489100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<18.269400,0.000000,52.624600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.404900,0.000000,52.489100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.676100,0.000000,52.489100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<18.404900,0.000000,52.489100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.676100,0.000000,52.489100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.811700,0.000000,52.624600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<18.676100,0.000000,52.489100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.036800,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.036800,0.000000,39.447100>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<15.036800,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.036800,0.000000,39.447100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.621400,0.000000,39.447100>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<15.036800,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.621400,0.000000,39.447100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.816300,0.000000,39.252200>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<15.621400,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.816300,0.000000,39.252200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.816300,0.000000,38.862400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<15.816300,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.816300,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.621400,0.000000,38.667500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<15.621400,0.000000,38.667500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.621400,0.000000,38.667500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.036800,0.000000,38.667500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<15.036800,0.000000,38.667500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.206100,0.000000,39.447100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.206100,0.000000,38.277800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<16.206100,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.206100,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.400900,0.000000,39.057300>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<16.206100,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.400900,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.790700,0.000000,39.057300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<16.400900,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.790700,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.985600,0.000000,38.862400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<16.790700,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.985600,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.985600,0.000000,38.277800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<16.985600,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.570200,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.960000,0.000000,38.277800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<17.570200,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.960000,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.154900,0.000000,38.472600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<17.960000,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.154900,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.154900,0.000000,38.862400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<18.154900,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.154900,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.960000,0.000000,39.057300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<17.960000,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.960000,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.570200,0.000000,39.057300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<17.570200,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.570200,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.375400,0.000000,38.862400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<17.375400,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.375400,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.375400,0.000000,38.472600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<17.375400,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.375400,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.570200,0.000000,38.277800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<17.375400,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.544700,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.544700,0.000000,39.057300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<18.544700,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.544700,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.129300,0.000000,39.057300>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<18.544700,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.129300,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.324200,0.000000,38.862400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<19.129300,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.324200,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.324200,0.000000,38.277800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<19.324200,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.714000,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.908800,0.000000,39.057300>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<19.714000,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.908800,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.908800,0.000000,38.277800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,-90.000000,0> translate<19.908800,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.714000,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.103700,0.000000,38.277800>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<19.714000,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.908800,0.000000,39.642000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.908800,0.000000,39.447100>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<19.908800,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.273000,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.688300,0.000000,39.057300>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<20.688300,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.688300,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.493500,0.000000,38.862400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<20.493500,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.493500,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.493500,0.000000,38.472600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<20.493500,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.493500,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.688300,0.000000,38.277800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<20.493500,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.688300,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.273000,0.000000,38.277800>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<20.688300,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.662800,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.662800,0.000000,39.447100>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<21.662800,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.662800,0.000000,39.447100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.247400,0.000000,39.447100>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<21.662800,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.247400,0.000000,39.447100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.442300,0.000000,39.252200>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<22.247400,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.442300,0.000000,39.252200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.442300,0.000000,39.057300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<22.442300,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.442300,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.247400,0.000000,38.862400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<22.247400,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.247400,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.442300,0.000000,38.667500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<22.247400,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.442300,0.000000,38.667500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.442300,0.000000,38.472600>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<22.442300,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.442300,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.247400,0.000000,38.277800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<22.247400,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.247400,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.662800,0.000000,38.277800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<21.662800,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.662800,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.247400,0.000000,38.862400>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<21.662800,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.026900,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.416700,0.000000,38.277800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<23.026900,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.416700,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.611600,0.000000,38.472600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<23.416700,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.611600,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.611600,0.000000,38.862400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<23.611600,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.611600,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.416700,0.000000,39.057300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<23.416700,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.416700,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.026900,0.000000,39.057300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<23.026900,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.026900,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.832100,0.000000,38.862400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<22.832100,0.000000,38.862400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.832100,0.000000,38.862400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.832100,0.000000,38.472600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<22.832100,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.832100,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.026900,0.000000,38.277800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<22.832100,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.196200,0.000000,39.252200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.196200,0.000000,38.472600>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,-90.000000,0> translate<24.196200,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.196200,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.391100,0.000000,38.277800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<24.196200,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.001400,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.391100,0.000000,39.057300>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<24.001400,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.950200,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.339900,0.000000,38.277800>}
box{<0,0,-0.050800><0.871485,0.036000,0.050800> rotate<0,63.433702,0> translate<25.950200,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.339900,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.729700,0.000000,39.057300>}
box{<0,0,-0.050800><0.871530,0.036000,0.050800> rotate<0,-63.427823,0> translate<26.339900,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.119500,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.509200,0.000000,39.447100>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<27.119500,0.000000,39.057300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.509200,0.000000,39.447100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.509200,0.000000,38.277800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<27.509200,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.119500,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.899000,0.000000,38.277800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<27.119500,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.288800,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.288800,0.000000,38.472600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<28.288800,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.288800,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.483600,0.000000,38.472600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<28.288800,0.000000,38.472600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.483600,0.000000,38.472600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.483600,0.000000,38.277800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<28.483600,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.483600,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.288800,0.000000,38.277800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<28.288800,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.652900,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.873400,0.000000,38.277800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<28.873400,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.873400,0.000000,38.277800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.652900,0.000000,39.057300>}
box{<0,0,-0.050800><1.102379,0.036000,0.050800> rotate<0,-44.997030,0> translate<28.873400,0.000000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.652900,0.000000,39.057300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.652900,0.000000,39.252200>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<29.652900,0.000000,39.252200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.652900,0.000000,39.252200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.458000,0.000000,39.447100>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<29.458000,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.458000,0.000000,39.447100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.068200,0.000000,39.447100>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<29.068200,0.000000,39.447100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.068200,0.000000,39.447100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.873400,0.000000,39.252200>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<28.873400,0.000000,39.252200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.798800,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.798800,0.000000,37.415100>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<15.798800,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.798800,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.188500,0.000000,37.025300>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,45.004380,0> translate<15.798800,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.188500,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.578300,0.000000,37.415100>}
box{<0,0,-0.050800><0.551260,0.036000,0.050800> rotate<0,-44.997030,0> translate<16.188500,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.578300,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.578300,0.000000,36.245800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<16.578300,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.162900,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.552700,0.000000,37.025300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<17.162900,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.552700,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.747600,0.000000,36.830400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<17.552700,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.747600,0.000000,36.830400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.747600,0.000000,36.245800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<17.747600,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.747600,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.162900,0.000000,36.245800>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<17.162900,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.162900,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.968100,0.000000,36.440600>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<16.968100,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.968100,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.162900,0.000000,36.635500>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<16.968100,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.162900,0.000000,36.635500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.747600,0.000000,36.635500>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<17.162900,0.000000,36.635500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.137400,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.137400,0.000000,37.025300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<18.137400,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.137400,0.000000,36.635500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.527100,0.000000,37.025300>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<18.137400,0.000000,36.635500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.527100,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.722000,0.000000,37.025300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<18.527100,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.891300,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.306600,0.000000,37.025300>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<19.306600,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.306600,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.111800,0.000000,36.830400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<19.111800,0.000000,36.830400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.111800,0.000000,36.830400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.111800,0.000000,36.440600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<19.111800,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.111800,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.306600,0.000000,36.245800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<19.111800,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.306600,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.891300,0.000000,36.245800>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<19.306600,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.281100,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.281100,0.000000,36.245800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<20.281100,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.281100,0.000000,36.830400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.475900,0.000000,37.025300>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<20.281100,0.000000,36.830400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.475900,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.865700,0.000000,37.025300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<20.475900,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.865700,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.060600,0.000000,36.830400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<20.865700,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.060600,0.000000,36.830400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.060600,0.000000,36.245800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<21.060600,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.399200,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.619700,0.000000,36.245800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<22.619700,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.619700,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.399200,0.000000,37.025300>}
box{<0,0,-0.050800><1.102379,0.036000,0.050800> rotate<0,-44.997030,0> translate<22.619700,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.399200,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.399200,0.000000,37.220200>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<23.399200,0.000000,37.220200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.399200,0.000000,37.220200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.204300,0.000000,37.415100>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<23.204300,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.204300,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.814500,0.000000,37.415100>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<22.814500,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.814500,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.619700,0.000000,37.220200>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<22.619700,0.000000,37.220200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.789000,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.789000,0.000000,37.220200>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,90.000000,0> translate<23.789000,0.000000,37.220200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.789000,0.000000,37.220200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.983800,0.000000,37.415100>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<23.789000,0.000000,37.220200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.983800,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.373600,0.000000,37.415100>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<23.983800,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.373600,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.568500,0.000000,37.220200>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<24.373600,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.568500,0.000000,37.220200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.568500,0.000000,36.440600>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,-90.000000,0> translate<24.568500,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.568500,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.373600,0.000000,36.245800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<24.373600,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.373600,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.983800,0.000000,36.245800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<23.983800,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.983800,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.789000,0.000000,36.440600>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<23.789000,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.789000,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.568500,0.000000,37.220200>}
box{<0,0,-0.050800><1.102450,0.036000,0.050800> rotate<0,-45.000705,0> translate<23.789000,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.958300,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.958300,0.000000,37.220200>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,90.000000,0> translate<24.958300,0.000000,37.220200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.958300,0.000000,37.220200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.153100,0.000000,37.415100>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<24.958300,0.000000,37.220200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.153100,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.542900,0.000000,37.415100>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<25.153100,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.542900,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.737800,0.000000,37.220200>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<25.542900,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.737800,0.000000,37.220200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.737800,0.000000,36.440600>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,-90.000000,0> translate<25.737800,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.737800,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.542900,0.000000,36.245800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<25.542900,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.542900,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.153100,0.000000,36.245800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<25.153100,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.153100,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.958300,0.000000,36.440600>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<24.958300,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.958300,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.737800,0.000000,37.220200>}
box{<0,0,-0.050800><1.102450,0.036000,0.050800> rotate<0,-45.000705,0> translate<24.958300,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.127600,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.517300,0.000000,37.415100>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<26.127600,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.517300,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.517300,0.000000,36.245800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<26.517300,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.127600,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.907100,0.000000,36.245800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<26.127600,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.466200,0.000000,36.830400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.245700,0.000000,36.830400>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<28.466200,0.000000,36.830400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.804800,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.804800,0.000000,36.245800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<30.804800,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.804800,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.389400,0.000000,36.245800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<30.804800,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.389400,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.584300,0.000000,36.440600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<31.389400,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.584300,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.584300,0.000000,37.220200>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,90.000000,0> translate<31.584300,0.000000,37.220200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.584300,0.000000,37.220200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.389400,0.000000,37.415100>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<31.389400,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.389400,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.804800,0.000000,37.415100>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<30.804800,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.753600,0.000000,37.220200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.558700,0.000000,37.415100>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<32.558700,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.558700,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.168900,0.000000,37.415100>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<32.168900,0.000000,37.415100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.168900,0.000000,37.415100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.974100,0.000000,37.220200>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<31.974100,0.000000,37.220200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.974100,0.000000,37.220200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.974100,0.000000,37.025300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<31.974100,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.974100,0.000000,37.025300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.168900,0.000000,36.830400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<31.974100,0.000000,37.025300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.168900,0.000000,36.830400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.558700,0.000000,36.830400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<32.168900,0.000000,36.830400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.558700,0.000000,36.830400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.753600,0.000000,36.635500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<32.558700,0.000000,36.830400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.753600,0.000000,36.635500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.753600,0.000000,36.440600>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<32.753600,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.753600,0.000000,36.440600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.558700,0.000000,36.245800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<32.558700,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.558700,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.168900,0.000000,36.245800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<32.168900,0.000000,36.245800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.168900,0.000000,36.245800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.974100,0.000000,36.440600>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<31.974100,0.000000,36.440600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.036100,0.000000,49.187100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.765000,0.000000,49.458200>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<29.765000,0.000000,49.458200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.765000,0.000000,49.458200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.765000,0.000000,49.729400>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,90.000000,0> translate<29.765000,0.000000,49.729400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.765000,0.000000,49.729400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.036100,0.000000,50.000500>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<29.765000,0.000000,49.729400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.310700,0.000000,50.000500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.853000,0.000000,49.187100>}
box{<0,0,-0.038100><0.977604,0.036000,0.038100> rotate<0,56.304591,0> translate<30.310700,0.000000,50.000500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.853000,0.000000,50.000500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.310700,0.000000,49.187100>}
box{<0,0,-0.038100><0.977604,0.036000,0.038100> rotate<0,-56.304591,0> translate<30.310700,0.000000,49.187100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.129200,0.000000,49.187100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.400300,0.000000,49.458200>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<31.129200,0.000000,49.187100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.400300,0.000000,49.458200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.400300,0.000000,49.729400>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,90.000000,0> translate<31.400300,0.000000,49.729400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.400300,0.000000,49.729400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.129200,0.000000,50.000500>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<31.129200,0.000000,50.000500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.674900,0.000000,50.000500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.674900,0.000000,49.458200>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<31.674900,0.000000,49.458200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.674900,0.000000,49.458200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.946000,0.000000,49.187100>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<31.674900,0.000000,49.458200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.946000,0.000000,49.187100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.217200,0.000000,49.458200>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,-44.986466,0> translate<31.946000,0.000000,49.187100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.217200,0.000000,49.458200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.217200,0.000000,50.000500>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<32.217200,0.000000,50.000500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.493400,0.000000,49.593800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.035700,0.000000,49.593800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<32.493400,0.000000,49.593800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.764500,0.000000,49.865000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.764500,0.000000,49.322600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<32.764500,0.000000,49.322600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,55.046200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.488800,0.000000,54.775100>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<34.488800,0.000000,54.775100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.488800,0.000000,54.775100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.217600,0.000000,54.775100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<34.217600,0.000000,54.775100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.217600,0.000000,54.775100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,55.046200>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<33.946500,0.000000,55.046200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,55.320800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.488800,0.000000,55.320800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<33.946500,0.000000,55.320800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.488800,0.000000,55.320800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,55.591900>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<34.488800,0.000000,55.320800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,55.591900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.488800,0.000000,55.863100>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,45.007595,0> translate<34.488800,0.000000,55.863100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.488800,0.000000,55.863100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,55.863100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<33.946500,0.000000,55.863100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,56.681600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,56.546000>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-45.018163,0> translate<33.946500,0.000000,56.546000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,56.546000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,56.274800>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,-90.000000,0> translate<33.946500,0.000000,56.274800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,56.274800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,56.139300>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<33.946500,0.000000,56.274800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,56.139300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.624400,0.000000,56.139300>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,0.000000,0> translate<34.082000,0.000000,56.139300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.624400,0.000000,56.139300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,56.274800>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<34.624400,0.000000,56.139300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,56.274800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,56.546000>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,90.000000,0> translate<34.759900,0.000000,56.546000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,56.546000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.624400,0.000000,56.681600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,45.018163,0> translate<34.624400,0.000000,56.681600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,57.500100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,57.364500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-45.018163,0> translate<33.946500,0.000000,57.364500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,57.364500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,57.093300>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,-90.000000,0> translate<33.946500,0.000000,57.093300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,57.093300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,56.957800>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<33.946500,0.000000,57.093300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,56.957800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.624400,0.000000,56.957800>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,0.000000,0> translate<34.082000,0.000000,56.957800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.624400,0.000000,56.957800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,57.093300>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<34.624400,0.000000,56.957800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,57.093300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,57.364500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,90.000000,0> translate<34.759900,0.000000,57.364500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,57.364500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.624400,0.000000,57.500100>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,45.018163,0> translate<34.624400,0.000000,57.500100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,57.776300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,58.318600>}
box{<0,0,-0.038100><0.977604,0.036000,0.038100> rotate<0,33.689470,0> translate<33.946500,0.000000,58.318600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,59.137100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,58.594800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<34.759900,0.000000,58.594800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,58.594800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.217600,0.000000,59.137100>}
box{<0,0,-0.038100><0.766928,0.036000,0.038100> rotate<0,44.997030,0> translate<34.217600,0.000000,59.137100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.217600,0.000000,59.137100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,59.137100>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,0.000000,0> translate<34.082000,0.000000,59.137100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,59.137100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,59.001500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-45.018163,0> translate<33.946500,0.000000,59.001500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,59.001500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,58.730300>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,-90.000000,0> translate<33.946500,0.000000,58.730300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,58.730300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.082000,0.000000,58.594800>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<33.946500,0.000000,58.730300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.759900,0.000000,59.413300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.488800,0.000000,59.684400>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,44.997030,0> translate<34.488800,0.000000,59.684400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.488800,0.000000,59.684400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.217600,0.000000,59.684400>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<34.217600,0.000000,59.684400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.217600,0.000000,59.684400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.946500,0.000000,59.413300>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<33.946500,0.000000,59.413300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.850000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.850000,0.000000,9.182100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<34.850000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.850000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.256700,0.000000,9.182100>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<34.850000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.256700,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.392300,0.000000,9.317600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<35.256700,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.392300,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.392300,0.000000,9.860000>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,90.000000,0> translate<35.392300,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.392300,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.256700,0.000000,9.995500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<35.256700,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.256700,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.850000,0.000000,9.995500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<34.850000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.210800,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.668500,0.000000,9.182100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<35.668500,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.668500,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.210800,0.000000,9.724400>}
box{<0,0,-0.038100><0.766928,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.668500,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.210800,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.210800,0.000000,9.860000>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,90.000000,0> translate<36.210800,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.210800,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.075200,0.000000,9.995500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<36.075200,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.075200,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.804000,0.000000,9.995500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<35.804000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.804000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.668500,0.000000,9.860000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.668500,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.137000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.137000,0.000000,9.182100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<45.137000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.137000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.543700,0.000000,9.182100>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<45.137000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.543700,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.679300,0.000000,9.317600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<45.543700,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.679300,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.679300,0.000000,9.860000>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,90.000000,0> translate<45.679300,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.679300,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.543700,0.000000,9.995500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<45.543700,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.543700,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.137000,0.000000,9.995500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<45.137000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.497800,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.226600,0.000000,9.860000>}
box{<0,0,-0.038100><0.303166,0.036000,0.038100> rotate<0,-26.546395,0> translate<46.226600,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.226600,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.955500,0.000000,9.588800>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,-45.007595,0> translate<45.955500,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.955500,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.955500,0.000000,9.317600>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,-90.000000,0> translate<45.955500,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.955500,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.091000,0.000000,9.182100>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<45.955500,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.091000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.362200,0.000000,9.182100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<46.091000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.362200,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.497800,0.000000,9.317600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<46.362200,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.497800,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.497800,0.000000,9.453200>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,90.000000,0> translate<46.497800,0.000000,9.453200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.497800,0.000000,9.453200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.362200,0.000000,9.588800>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<46.362200,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.362200,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.955500,0.000000,9.588800>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<45.955500,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.597000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.597000,0.000000,9.182100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<42.597000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.597000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.003700,0.000000,9.182100>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<42.597000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.003700,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.139300,0.000000,9.317600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<43.003700,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.139300,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.139300,0.000000,9.860000>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,90.000000,0> translate<43.139300,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.139300,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.003700,0.000000,9.995500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<43.003700,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.003700,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.597000,0.000000,9.995500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<42.597000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.957800,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.415500,0.000000,9.995500>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<43.415500,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.415500,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.415500,0.000000,9.588800>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.415500,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.415500,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.686600,0.000000,9.724400>}
box{<0,0,-0.038100><0.303121,0.036000,0.038100> rotate<0,-26.571751,0> translate<43.415500,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.686600,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.822200,0.000000,9.724400>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,0.000000,0> translate<43.686600,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.822200,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.957800,0.000000,9.588800>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<43.822200,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.957800,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.957800,0.000000,9.317600>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.957800,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.957800,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.822200,0.000000,9.182100>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<43.822200,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.822200,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.551000,0.000000,9.182100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<43.551000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.551000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.415500,0.000000,9.317600>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<43.415500,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.437000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.437000,0.000000,9.724400>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<32.437000,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.437000,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.708100,0.000000,9.995500>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<32.437000,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.708100,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.979300,0.000000,9.724400>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,44.986466,0> translate<32.708100,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.979300,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.979300,0.000000,9.182100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<32.979300,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.437000,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.979300,0.000000,9.588800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<32.437000,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.255500,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.255500,0.000000,9.860000>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,90.000000,0> translate<33.255500,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.255500,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.391000,0.000000,9.995500>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<33.255500,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.391000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.662200,0.000000,9.995500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<33.391000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.662200,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.797800,0.000000,9.860000>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<33.662200,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.797800,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.797800,0.000000,9.317600>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,-90.000000,0> translate<33.797800,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.797800,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.662200,0.000000,9.182100>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<33.662200,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.662200,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.391000,0.000000,9.182100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<33.391000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.391000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.255500,0.000000,9.317600>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<33.255500,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.255500,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.797800,0.000000,9.860000>}
box{<0,0,-0.038100><0.766999,0.036000,0.038100> rotate<0,-45.002312,0> translate<33.255500,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.897000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.897000,0.000000,9.724400>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<29.897000,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.897000,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.168100,0.000000,9.995500>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<29.897000,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.168100,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.439300,0.000000,9.724400>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,44.986466,0> translate<30.168100,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.439300,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.439300,0.000000,9.182100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.439300,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.897000,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.439300,0.000000,9.588800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<29.897000,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.715500,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.986600,0.000000,9.995500>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<30.715500,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.986600,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.986600,0.000000,9.182100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<30.986600,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.715500,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.257800,0.000000,9.182100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<30.715500,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.357000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.357000,0.000000,9.724400>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<27.357000,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.357000,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.628100,0.000000,9.995500>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<27.357000,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.628100,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.899300,0.000000,9.724400>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,44.986466,0> translate<27.628100,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.899300,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.899300,0.000000,9.182100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<27.899300,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.357000,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.899300,0.000000,9.588800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<27.357000,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.717800,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.175500,0.000000,9.182100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<28.175500,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.175500,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.717800,0.000000,9.724400>}
box{<0,0,-0.038100><0.766928,0.036000,0.038100> rotate<0,-44.997030,0> translate<28.175500,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.717800,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.717800,0.000000,9.860000>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,90.000000,0> translate<28.717800,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.717800,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.582200,0.000000,9.995500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<28.582200,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.582200,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.311000,0.000000,9.995500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<28.311000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.311000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.175500,0.000000,9.860000>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<28.175500,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.817000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.817000,0.000000,9.724400>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,90.000000,0> translate<24.817000,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.817000,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.088100,0.000000,9.995500>}
box{<0,0,-0.038100><0.383393,0.036000,0.038100> rotate<0,-44.997030,0> translate<24.817000,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.088100,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.359300,0.000000,9.724400>}
box{<0,0,-0.038100><0.383464,0.036000,0.038100> rotate<0,44.986466,0> translate<25.088100,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.359300,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.359300,0.000000,9.182100>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,-90.000000,0> translate<25.359300,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.817000,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.359300,0.000000,9.588800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<24.817000,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.635500,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.771000,0.000000,9.995500>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<25.635500,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.771000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.042200,0.000000,9.995500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<25.771000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.042200,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.177800,0.000000,9.860000>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<26.042200,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.177800,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.177800,0.000000,9.724400>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<26.177800,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.177800,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.042200,0.000000,9.588800>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,-44.997030,0> translate<26.042200,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.042200,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.906600,0.000000,9.588800>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,0.000000,0> translate<25.906600,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.042200,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.177800,0.000000,9.453200>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<26.042200,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.177800,0.000000,9.453200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.177800,0.000000,9.317600>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<26.177800,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.177800,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.042200,0.000000,9.182100>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<26.042200,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.042200,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.771000,0.000000,9.182100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<25.771000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.771000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.635500,0.000000,9.317600>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<25.635500,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.517000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.517000,0.000000,9.182100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.517000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.517000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.923700,0.000000,9.182100>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<37.517000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.923700,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.059300,0.000000,9.317600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<37.923700,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.059300,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.059300,0.000000,9.860000>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,90.000000,0> translate<38.059300,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.059300,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.923700,0.000000,9.995500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<37.923700,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.923700,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.517000,0.000000,9.995500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<37.517000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.335500,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.471000,0.000000,9.995500>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,-44.997030,0> translate<38.335500,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.471000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.742200,0.000000,9.995500>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<38.471000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.742200,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.877800,0.000000,9.860000>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<38.742200,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.877800,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.877800,0.000000,9.724400>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.877800,0.000000,9.724400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.877800,0.000000,9.724400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.742200,0.000000,9.588800>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,-44.997030,0> translate<38.742200,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.742200,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.606600,0.000000,9.588800>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,0.000000,0> translate<38.606600,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.742200,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.877800,0.000000,9.453200>}
box{<0,0,-0.038100><0.191767,0.036000,0.038100> rotate<0,44.997030,0> translate<38.742200,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.877800,0.000000,9.453200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.877800,0.000000,9.317600>}
box{<0,0,-0.038100><0.135600,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.877800,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.877800,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.742200,0.000000,9.182100>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<38.742200,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.742200,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.471000,0.000000,9.182100>}
box{<0,0,-0.038100><0.271200,0.036000,0.038100> rotate<0,0.000000,0> translate<38.471000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.471000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.335500,0.000000,9.317600>}
box{<0,0,-0.038100><0.191626,0.036000,0.038100> rotate<0,44.997030,0> translate<38.335500,0.000000,9.317600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.057000,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.057000,0.000000,9.182100>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.057000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.057000,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.463700,0.000000,9.182100>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<40.057000,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.463700,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.599300,0.000000,9.317600>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,-44.975897,0> translate<40.463700,0.000000,9.182100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.599300,0.000000,9.317600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.599300,0.000000,9.860000>}
box{<0,0,-0.038100><0.542400,0.036000,0.038100> rotate<0,90.000000,0> translate<40.599300,0.000000,9.860000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.599300,0.000000,9.860000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.463700,0.000000,9.995500>}
box{<0,0,-0.038100><0.191697,0.036000,0.038100> rotate<0,44.975897,0> translate<40.463700,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.463700,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.057000,0.000000,9.995500>}
box{<0,0,-0.038100><0.406700,0.036000,0.038100> rotate<0,0.000000,0> translate<40.057000,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.282200,0.000000,9.182100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.282200,0.000000,9.995500>}
box{<0,0,-0.038100><0.813400,0.036000,0.038100> rotate<0,90.000000,0> translate<41.282200,0.000000,9.995500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.282200,0.000000,9.995500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.875500,0.000000,9.588800>}
box{<0,0,-0.038100><0.575161,0.036000,0.038100> rotate<0,-44.997030,0> translate<40.875500,0.000000,9.588800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.875500,0.000000,9.588800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.417800,0.000000,9.588800>}
box{<0,0,-0.038100><0.542300,0.036000,0.038100> rotate<0,0.000000,0> translate<40.875500,0.000000,9.588800> }
//BTM8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.420000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.420000,0.000000,17.145000>}
box{<0,0,-0.127000><16.510000,0.036000,0.127000> rotate<0,-90.000000,0> translate<58.420000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.420000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.700000,0.000000,17.145000>}
box{<0,0,-0.127000><45.720000,0.036000,0.127000> rotate<0,0.000000,0> translate<12.700000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.700000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.700000,0.000000,33.655000>}
box{<0,0,-0.127000><16.510000,0.036000,0.127000> rotate<0,90.000000,0> translate<12.700000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.700000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.420000,0.000000,33.655000>}
box{<0,0,-0.127000><45.720000,0.036000,0.127000> rotate<0,0.000000,0> translate<12.700000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.700000,0.000000,33.020000>}
box{<0,0,-0.127000><8.890000,0.036000,0.127000> rotate<0,0.000000,0> translate<3.810000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.700000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,17.780000>}
box{<0,0,-0.127000><8.890000,0.036000,0.127000> rotate<0,0.000000,0> translate<3.810000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,19.050000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<3.810000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<3.810000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,24.130000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<3.810000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,26.670000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<3.810000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,29.210000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<3.810000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,31.750000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<3.810000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.810000,0.000000,33.020000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<3.810000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<3.810000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<2.540000,0.000000,31.750000>}
box{<0,0,-0.304800><1.270000,0.036000,0.304800> rotate<0,0.000000,0> translate<2.540000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<3.810000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<2.540000,0.000000,29.210000>}
box{<0,0,-0.304800><1.270000,0.036000,0.304800> rotate<0,0.000000,0> translate<2.540000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<3.810000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<2.540000,0.000000,26.670000>}
box{<0,0,-0.304800><1.270000,0.036000,0.304800> rotate<0,0.000000,0> translate<2.540000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<3.810000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<2.540000,0.000000,24.130000>}
box{<0,0,-0.304800><1.270000,0.036000,0.304800> rotate<0,0.000000,0> translate<2.540000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<3.810000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<2.540000,0.000000,21.590000>}
box{<0,0,-0.304800><1.270000,0.036000,0.304800> rotate<0,0.000000,0> translate<2.540000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<3.810000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<2.540000,0.000000,19.050000>}
box{<0,0,-0.304800><1.270000,0.036000,0.304800> rotate<0,0.000000,0> translate<2.540000,0.000000,19.050000> }
difference{
cylinder{<13.970000,0,31.750000><13.970000,0.036000,31.750000>0.698500 translate<0,0.000000,0>}
cylinder{<13.970000,-0.1,31.750000><13.970000,0.135000,31.750000>0.571500 translate<0,0.000000,0>}}
difference{
cylinder{<13.970000,0,29.210000><13.970000,0.036000,29.210000>0.698500 translate<0,0.000000,0>}
cylinder{<13.970000,-0.1,29.210000><13.970000,0.135000,29.210000>0.571500 translate<0,0.000000,0>}}
difference{
cylinder{<13.970000,0,26.670000><13.970000,0.036000,26.670000>0.698500 translate<0,0.000000,0>}
cylinder{<13.970000,-0.1,26.670000><13.970000,0.135000,26.670000>0.571500 translate<0,0.000000,0>}}
difference{
cylinder{<13.970000,0,24.130000><13.970000,0.036000,24.130000>0.698500 translate<0,0.000000,0>}
cylinder{<13.970000,-0.1,24.130000><13.970000,0.135000,24.130000>0.571500 translate<0,0.000000,0>}}
difference{
cylinder{<13.970000,0,21.590000><13.970000,0.036000,21.590000>0.698500 translate<0,0.000000,0>}
cylinder{<13.970000,-0.1,21.590000><13.970000,0.135000,21.590000>0.571500 translate<0,0.000000,0>}}
difference{
cylinder{<13.970000,0,19.050000><13.970000,0.036000,19.050000>0.698500 translate<0,0.000000,0>}
cylinder{<13.970000,-0.1,19.050000><13.970000,0.135000,19.050000>0.571500 translate<0,0.000000,0>}}
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.272000,0.000000,45.593000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.288000,0.000000,45.593000>}
box{<0,0,-0.101600><1.016000,0.036000,0.101600> rotate<0,0.000000,0> translate<17.272000,0.000000,45.593000> }
difference{
cylinder{<16.510000,0,46.990000><16.510000,0.036000,46.990000>2.601600 translate<0,0.000000,0>}
cylinder{<16.510000,-0.1,46.990000><16.510000,0.135000,46.990000>2.398400 translate<0,0.000000,0>}}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.162000,0.000000,46.863000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.178000,0.000000,46.863000>}
box{<0,0,-0.101600><1.016000,0.036000,0.101600> rotate<0,0.000000,0> translate<26.162000,0.000000,46.863000> }
difference{
cylinder{<25.400000,0,48.260000><25.400000,0.036000,48.260000>2.601600 translate<0,0.000000,0>}
cylinder{<25.400000,-0.1,48.260000><25.400000,0.135000,48.260000>2.398400 translate<0,0.000000,0>}}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,44.450000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<28.575000,0.000000,44.450000> }
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.435000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,57.150000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<50.165000,0.000000,57.150000> }
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,23.495000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<50.800000,0.000000,23.495000> }
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.610000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.610000,0.000000,8.255000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<54.610000,0.000000,8.255000> }
//C7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.482000,0.000000,55.753000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.498000,0.000000,55.753000>}
box{<0,0,-0.101600><1.016000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.482000,0.000000,55.753000> }
difference{
cylinder{<45.720000,0,57.150000><45.720000,0.036000,57.150000>2.601600 translate<0,0.000000,0>}
cylinder{<45.720000,-0.1,57.150000><45.720000,0.135000,57.150000>2.398400 translate<0,0.000000,0>}}
//C8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.560000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.560000,0.000000,12.065000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<35.560000,0.000000,12.065000> }
//C9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,33.020000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<24.765000,0.000000,33.020000> }
//C10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.192000,0.000000,35.433000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.208000,0.000000,35.433000>}
box{<0,0,-0.101600><1.016000,0.036000,0.101600> rotate<0,0.000000,0> translate<12.192000,0.000000,35.433000> }
difference{
cylinder{<11.430000,0,36.830000><11.430000,0.036000,36.830000>2.601600 translate<0,0.000000,0>}
cylinder{<11.430000,-0.1,36.830000><11.430000,0.135000,36.830000>2.398400 translate<0,0.000000,0>}}
//C11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.525000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.795000,0.000000,26.670000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<9.525000,0.000000,26.670000> }
//C12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.335000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.605000,0.000000,20.320000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.335000,0.000000,20.320000> }
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,50.038000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.890000,0.000000,50.038000>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.890000,0.000000,50.038000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.890000,0.000000,50.038000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.890000,0.000000,50.800000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,90.000000,0> translate<8.890000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.890000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.890000,0.000000,51.562000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,90.000000,0> translate<8.890000,0.000000,51.562000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.890000,0.000000,51.562000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,51.562000>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.890000,0.000000,51.562000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,51.562000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,50.800000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,-90.000000,0> translate<13.970000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,50.038000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,-90.000000,0> translate<13.970000,0.000000,50.038000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.890000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.636000,0.000000,50.800000>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.636000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.224000,0.000000,50.800000>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.970000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.525000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.525000,0.000000,51.435000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<9.525000,0.000000,51.435000> }
//I2C_A silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.782000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,38.100000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<33.782000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.782000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,53.340000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<33.782000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.782000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.782000,0.000000,38.100000>}
box{<0,0,-0.063500><15.240000,0.036000,0.063500> rotate<0,-90.000000,0> translate<33.782000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,52.070000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<39.370000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,39.370000>}
box{<0,0,-0.063500><12.700000,0.036000,0.063500> rotate<0,-90.000000,0> translate<39.370000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,38.100000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<39.370000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.100000,0.000000,39.370000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<38.100000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.100000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.100000,0.000000,52.070000>}
box{<0,0,-0.063500><12.700000,0.036000,0.063500> rotate<0,90.000000,0> translate<38.100000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.100000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.370000,0.000000,52.070000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<38.100000,0.000000,52.070000> }
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<36.957000,0.000000,39.370000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<36.957000,0.000000,41.910000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<36.957000,0.000000,44.450000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<36.957000,0.000000,46.990000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<36.957000,0.000000,49.530000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<36.957000,0.000000,52.070000>}
//I2C_B silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.132000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,38.100000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.132000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.132000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,53.340000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.132000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.132000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.132000,0.000000,38.100000>}
box{<0,0,-0.063500><15.240000,0.036000,0.063500> rotate<0,-90.000000,0> translate<40.132000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,52.070000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<45.720000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,39.370000>}
box{<0,0,-0.063500><12.700000,0.036000,0.063500> rotate<0,-90.000000,0> translate<45.720000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,38.100000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<45.720000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<44.450000,0.000000,39.370000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<44.450000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<44.450000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<44.450000,0.000000,52.070000>}
box{<0,0,-0.063500><12.700000,0.036000,0.063500> rotate<0,90.000000,0> translate<44.450000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<44.450000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.720000,0.000000,52.070000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<44.450000,0.000000,52.070000> }
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<43.307000,0.000000,39.370000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<43.307000,0.000000,41.910000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<43.307000,0.000000,44.450000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<43.307000,0.000000,46.990000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<43.307000,0.000000,49.530000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<43.307000,0.000000,52.070000>}
//I2C_C silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.482000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,38.100000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<46.482000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.482000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,53.340000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<46.482000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.482000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.482000,0.000000,38.100000>}
box{<0,0,-0.063500><15.240000,0.036000,0.063500> rotate<0,-90.000000,0> translate<46.482000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,52.070000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<52.070000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,39.370000>}
box{<0,0,-0.063500><12.700000,0.036000,0.063500> rotate<0,-90.000000,0> translate<52.070000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,38.100000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<52.070000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<50.800000,0.000000,39.370000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<50.800000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<50.800000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<50.800000,0.000000,52.070000>}
box{<0,0,-0.063500><12.700000,0.036000,0.063500> rotate<0,90.000000,0> translate<50.800000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<50.800000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,52.070000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<50.800000,0.000000,52.070000> }
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<49.657000,0.000000,39.370000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<49.657000,0.000000,41.910000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<49.657000,0.000000,44.450000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<49.657000,0.000000,46.990000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<49.657000,0.000000,49.530000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<49.657000,0.000000,52.070000>}
//I2C_X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.832000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,38.100000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<52.832000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.832000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,53.340000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<52.832000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.832000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.832000,0.000000,38.100000>}
box{<0,0,-0.063500><15.240000,0.036000,0.063500> rotate<0,-90.000000,0> translate<52.832000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,52.070000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<58.420000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,39.370000>}
box{<0,0,-0.063500><12.700000,0.036000,0.063500> rotate<0,-90.000000,0> translate<58.420000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,38.100000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<58.420000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<57.150000,0.000000,39.370000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<57.150000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<57.150000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<57.150000,0.000000,52.070000>}
box{<0,0,-0.063500><12.700000,0.036000,0.063500> rotate<0,90.000000,0> translate<57.150000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<57.150000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.420000,0.000000,52.070000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<57.150000,0.000000,52.070000> }
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<56.007000,0.000000,39.370000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<56.007000,0.000000,41.910000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<56.007000,0.000000,44.450000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<56.007000,0.000000,46.990000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<56.007000,0.000000,49.530000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<56.007000,0.000000,52.070000>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<31.750000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<31.623000,0.000000,53.086000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,-87.504672,0> translate<31.623000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<31.369000,0.000000,52.832000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<31.623000,0.000000,53.086000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,-44.997030,0> translate<31.369000,0.000000,52.832000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<31.369000,0.000000,52.832000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.971000,0.000000,52.832000>}
box{<0,0,-0.063500><9.398000,0.036000,0.063500> rotate<0,0.000000,0> translate<21.971000,0.000000,52.832000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.971000,0.000000,52.832000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,44.997030,0> translate<21.717000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.590000,0.000000,56.007000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,87.504672,0> translate<21.590000,0.000000,56.007000> }
difference{
cylinder{<22.174200,0,53.441600><22.174200,0.036000,53.441600>0.317500 translate<0,0.000000,0>}
cylinder{<22.174200,-0.1,53.441600><22.174200,0.135000,53.441600>0.190500 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-0.000000,0> translate<26.670000,0.000000,56.769000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-0.000000,0> translate<22.288500,0.000000,56.134000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<25.400000,0.000000,56.134000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-0.000000,0> translate<24.130000,0.000000,56.134000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<27.940000,0.000000,56.134000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-0.000000,0> translate<31.051500,0.000000,56.134000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-0.000000,0> translate<26.670000,0.000000,56.134000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-0.000000,0> translate<29.210000,0.000000,56.134000>}
//IC2 silk screen
object{ARC(2.667000,0.152400,197.146796,308.245791,0.036000) translate<39.370000,0.000000,57.150000>}
object{ARC(2.666900,0.152400,51.752879,162.852571,0.036000) translate<39.370000,0.000000,57.150500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,55.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,59.245000>}
box{<0,0,-0.076200><4.190000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.021000,0.000000,59.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,54.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,54.896000>}
box{<0,0,-0.076200><0.401000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.624000,0.000000,54.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,59.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,59.805000>}
box{<0,0,-0.076200><0.401000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.624000,0.000000,59.805000> }
object{ARC(2.667000,0.152400,162.853204,197.146796,0.036000) translate<39.370000,0.000000,57.150000>}
//IC3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.748000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.748000,0.000000,14.986000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.748000,0.000000,14.986000> }
object{ARC(0.635000,0.152400,270.000000,450.000000,0.036000) translate<15.748000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.748000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.832000,0.000000,14.986000>}
box{<0,0,-0.076200><37.084000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.748000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.748000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.748000,0.000000,18.415000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.748000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.748000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.832000,0.000000,20.574000>}
box{<0,0,-0.076200><37.084000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.748000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.832000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.832000,0.000000,14.986000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.832000,0.000000,14.986000> }
//IC4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,32.131000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.700000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,26.289000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,26.289000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.700000,0.000000,26.289000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,26.289000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.860000,0.000000,26.289000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,30.226000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.700000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,26.289000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,28.194000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.700000,0.000000,28.194000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<12.700000,0.000000,29.210000>}
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<19.050000,0.000000,54.102000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<19.050000,0.000000,59.690000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,90.000000,0> translate<19.050000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.970000,0.000000,54.102000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.970000,0.000000,59.690000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,90.000000,0> translate<13.970000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.970000,0.000000,54.102000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<19.050000,0.000000,54.102000>}
box{<0,0,-0.063500><5.080000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.970000,0.000000,54.102000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.970000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.240000,0.000000,59.690000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.970000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.240000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.780000,0.000000,59.690000>}
box{<0,0,-0.063500><2.540000,0.036000,0.063500> rotate<0,0.000000,0> translate<15.240000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.780000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<19.050000,0.000000,59.690000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<17.780000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.780000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.780000,0.000000,58.420000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<17.780000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.780000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.240000,0.000000,58.420000>}
box{<0,0,-0.063500><2.540000,0.036000,0.063500> rotate<0,0.000000,0> translate<15.240000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.240000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.240000,0.000000,59.690000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<15.240000,0.000000,59.690000> }
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-180.000000,0> translate<17.780000,0.000000,57.150000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-180.000000,0> translate<15.240000,0.000000,57.150000>}
//JP2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.700000,0.000000,54.102000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.700000,0.000000,59.690000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,90.000000,0> translate<12.700000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.620000,0.000000,54.102000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.620000,0.000000,59.690000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,90.000000,0> translate<7.620000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.620000,0.000000,54.102000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.700000,0.000000,54.102000>}
box{<0,0,-0.063500><5.080000,0.036000,0.063500> rotate<0,0.000000,0> translate<7.620000,0.000000,54.102000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.620000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.890000,0.000000,59.690000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<7.620000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.890000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.430000,0.000000,59.690000>}
box{<0,0,-0.063500><2.540000,0.036000,0.063500> rotate<0,0.000000,0> translate<8.890000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.430000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.700000,0.000000,59.690000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<11.430000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.430000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.430000,0.000000,58.420000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<11.430000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.430000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.890000,0.000000,58.420000>}
box{<0,0,-0.063500><2.540000,0.036000,0.063500> rotate<0,0.000000,0> translate<8.890000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.890000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.890000,0.000000,59.690000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<8.890000,0.000000,59.690000> }
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-180.000000,0> translate<11.430000,0.000000,57.150000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-180.000000,0> translate<8.890000,0.000000,57.150000>}
//JP3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.810000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.810000,0.000000,48.895000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<3.810000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.810000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.175000,0.000000,48.260000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.175000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.905000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.270000,0.000000,48.895000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<1.270000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.175000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.810000,0.000000,47.625000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<3.175000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.810000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.810000,0.000000,46.355000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<3.810000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.810000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.175000,0.000000,45.720000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.175000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.905000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.270000,0.000000,46.355000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<1.270000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.270000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.270000,0.000000,47.625000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.270000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.270000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.905000,0.000000,48.260000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<1.270000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.175000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.905000,0.000000,50.800000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.905000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.810000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.175000,0.000000,50.800000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<3.175000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.905000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.270000,0.000000,50.165000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<1.270000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.270000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.270000,0.000000,50.165000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.270000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.175000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.905000,0.000000,45.720000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<1.905000,0.000000,45.720000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<2.540000,0.000000,46.990000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<2.540000,0.000000,49.530000>}
//JP4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.320000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.955000,0.000000,7.620000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<20.320000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.955000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.225000,0.000000,7.620000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<20.955000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.225000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.860000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<22.225000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.860000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.225000,0.000000,5.080000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<22.225000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.225000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.955000,0.000000,5.080000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<20.955000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.955000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.320000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<20.320000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.875000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.145000,0.000000,7.620000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<15.875000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.145000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.780000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<17.145000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.780000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.145000,0.000000,5.080000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<17.145000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.780000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.415000,0.000000,7.620000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<17.780000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.415000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.685000,0.000000,7.620000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<18.415000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.685000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.320000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<19.685000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.320000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.685000,0.000000,5.080000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<19.685000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.685000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.415000,0.000000,5.080000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<18.415000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.415000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.780000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<17.780000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.700000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.335000,0.000000,7.620000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<12.700000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.335000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.605000,0.000000,7.620000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.335000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.605000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.240000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<14.605000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.240000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.605000,0.000000,5.080000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<14.605000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.605000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.335000,0.000000,5.080000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.335000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.335000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.700000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<12.700000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.875000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.240000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<15.240000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.240000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.875000,0.000000,5.080000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<15.240000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.145000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.875000,0.000000,5.080000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<15.875000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.255000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.525000,0.000000,7.620000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.255000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.525000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.160000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<9.525000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.160000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.525000,0.000000,5.080000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<9.525000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.160000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.795000,0.000000,7.620000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<10.160000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.795000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.065000,0.000000,7.620000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<10.795000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.065000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.700000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<12.065000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.700000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.065000,0.000000,5.080000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<12.065000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.065000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.795000,0.000000,5.080000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<10.795000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.795000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.160000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<10.160000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.620000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.620000,0.000000,5.715000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<7.620000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.255000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.620000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<7.620000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.620000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.255000,0.000000,5.080000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<7.620000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.525000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.255000,0.000000,5.080000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.255000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.860000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.860000,0.000000,5.715000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<22.860000,0.000000,5.715000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<21.590000,0.000000,6.350000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<19.050000,0.000000,6.350000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<16.510000,0.000000,6.350000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<13.970000,0.000000,6.350000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<11.430000,0.000000,6.350000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<8.890000,0.000000,6.350000>}
//JP5 silk screen
//JP6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.762000,0.000000,34.417000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,34.417000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<0.762000,0.000000,34.417000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.762000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,39.497000>}
box{<0,0,-0.063500><5.588000,0.036000,0.063500> rotate<0,0.000000,0> translate<0.762000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.762000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.762000,0.000000,34.417000>}
box{<0,0,-0.063500><5.080000,0.036000,0.063500> rotate<0,-90.000000,0> translate<0.762000,0.000000,34.417000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,38.227000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.350000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,38.227000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,35.687000>}
box{<0,0,-0.063500><2.540000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.350000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,34.417000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.350000,0.000000,34.417000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.080000,0.000000,35.687000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<5.080000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.080000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.080000,0.000000,38.227000>}
box{<0,0,-0.063500><2.540000,0.036000,0.063500> rotate<0,90.000000,0> translate<5.080000,0.000000,38.227000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.080000,0.000000,38.227000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.350000,0.000000,38.227000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<5.080000,0.000000,38.227000> }
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<3.810000,0.000000,35.687000>}
box{<-0.292100,0,-0.292100><0.292100,0.036000,0.292100> rotate<0,-90.000000,0> translate<3.810000,0.000000,38.227000>}
//JP7 silk screen
//JP8 silk screen
//JP9 silk screen
//JP10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<40.005000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<41.275000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<41.275000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<36.830000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.465000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<38.735000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<38.735000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.465000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,1.905000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<36.830000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<39.370000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<39.370000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<40.005000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<32.385000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<33.655000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<33.655000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<34.290000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.925000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<36.195000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<36.195000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.925000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,1.905000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<34.290000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<29.210000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.845000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<31.115000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<31.115000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.845000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,1.905000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<29.210000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<31.750000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<31.750000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<32.385000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<24.765000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<26.035000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<26.035000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<26.670000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<27.305000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<28.575000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<28.575000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<27.305000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,1.905000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<26.670000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,1.905000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<24.130000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<24.130000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<24.130000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<24.765000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.545000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<43.815000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<43.815000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<41.910000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<41.910000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.545000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.085000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<46.355000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<46.355000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<44.450000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<44.450000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.085000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,1.905000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<46.990000,0.000000,1.905000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<40.640000,0.000000,2.540000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<38.100000,0.000000,2.540000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<35.560000,0.000000,2.540000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<33.020000,0.000000,2.540000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<30.480000,0.000000,2.540000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<27.940000,0.000000,2.540000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<25.400000,0.000000,2.540000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<43.180000,0.000000,2.540000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<45.720000,0.000000,2.540000>}
//JP11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<40.005000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<41.275000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<41.275000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<36.830000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.465000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<38.735000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<38.735000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.465000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,4.445000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<36.830000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<39.370000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<39.370000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<40.005000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<32.385000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<33.655000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<33.655000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<34.290000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.925000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<36.195000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<36.195000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.925000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,4.445000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<34.290000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<29.210000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.845000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<31.115000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<31.115000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.845000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,4.445000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<29.210000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<31.750000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<31.750000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<32.385000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<24.765000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<26.035000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<26.035000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<26.670000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<27.305000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<28.575000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<28.575000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<27.305000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,4.445000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<26.670000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,4.445000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<24.130000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<24.130000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<24.130000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<24.765000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.545000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<43.815000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<43.815000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<41.910000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<41.910000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.545000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.085000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<46.355000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<46.355000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<44.450000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<44.450000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,3.810000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.085000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,4.445000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<46.990000,0.000000,4.445000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<40.640000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<38.100000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<35.560000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<33.020000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<30.480000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<27.940000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<25.400000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<43.180000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<45.720000,0.000000,5.080000>}
//JP12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.545000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<43.815000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<43.815000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<44.450000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.085000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<46.355000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<46.355000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.355000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.085000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.085000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<44.450000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<39.370000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<40.005000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<41.275000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<41.275000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<40.005000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.005000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<39.370000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<41.910000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.910000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<41.910000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<43.815000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.545000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.545000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.925000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<36.195000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<36.195000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<36.830000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.465000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<38.735000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<38.735000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.735000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.465000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.830000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<36.830000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,6.985000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<34.290000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<34.290000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<34.290000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.195000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.925000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.925000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.990000,0.000000,6.985000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<46.990000,0.000000,6.985000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<45.720000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<43.180000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<40.640000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<38.100000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<35.560000,0.000000,7.620000>}
//JP13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.895000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<48.260000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,8.255000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<48.260000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.895000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<48.260000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<50.165000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,6.985000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<50.800000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<50.165000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,3.175000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<48.260000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.895000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<48.260000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,3.175000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<50.165000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.895000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,4.445000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<48.260000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,5.715000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<48.260000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.895000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<48.260000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,5.715000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<50.165000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,4.445000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<50.800000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,3.810000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<50.165000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.895000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,1.270000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<48.895000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.895000,0.000000,1.270000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<48.260000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,1.905000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<50.165000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.800000,0.000000,1.905000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<50.800000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.895000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.165000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<48.895000,0.000000,8.890000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<49.530000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<49.530000,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<49.530000,0.000000,2.540000>}
//JP15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<24.765000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<24.130000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<24.130000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<28.575000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<27.305000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<26.670000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<26.670000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.305000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<27.305000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.575000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<28.575000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<26.035000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<26.035000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.765000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.035000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<24.765000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<32.385000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<31.750000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<31.750000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,6.350000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<31.115000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,6.350000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.845000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<29.210000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<29.210000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.845000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.845000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.115000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.750000,0.000000,8.255000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<31.115000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,8.255000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.290000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,6.985000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<33.655000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,8.890000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<33.655000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.385000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,8.890000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<32.385000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.130000,0.000000,8.255000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<24.130000,0.000000,8.255000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<25.400000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<27.940000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<30.480000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<33.020000,0.000000,7.620000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.620000,0.000000,45.415200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.160000,0.000000,45.415200>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,0.000000,0> translate<7.620000,0.000000,45.415200> }
object{ARC(2.032000,0.254000,309.807015,360.000000,0.036000) translate<8.890000,0.000000,46.990000>}
object{ARC(2.032000,0.254000,0.002820,61.929172,0.036000) translate<8.890000,0.000000,46.989900>}
object{ARC(2.032000,0.254000,180.000000,229.762648,0.036000) translate<8.890000,0.000000,46.990000>}
object{ARC(2.032000,0.254000,119.746980,180.002820,0.036000) translate<8.890000,0.000000,46.990100>}
object{ARC(2.032000,0.254000,61.698289,90.000000,0.036000) translate<8.890000,0.000000,46.990000>}
object{ARC(2.032000,0.254000,89.997180,121.605470,0.036000) translate<8.889900,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.185400,0.000000,45.415200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.677400,0.000000,45.415200>}
box{<0,0,-0.127000><0.508000,0.036000,0.127000> rotate<0,0.000000,0> translate<9.677400,0.000000,45.415200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.594600,0.000000,45.415200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.051800,0.000000,45.415200>}
box{<0,0,-0.127000><0.457200,0.036000,0.127000> rotate<0,0.000000,0> translate<7.594600,0.000000,45.415200> }
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.470000,0.000000,40.710000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.470000,0.000000,43.110000>}
box{<0,0,-0.101600><2.400000,0.036000,0.101600> rotate<0,90.000000,0> translate<4.470000,0.000000,43.110000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.470000,0.000000,43.110000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.770000,0.000000,43.110000>}
box{<0,0,-0.101600><6.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.470000,0.000000,43.110000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.770000,0.000000,43.110000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.770000,0.000000,40.710000>}
box{<0,0,-0.101600><2.400000,0.036000,0.101600> rotate<0,-90.000000,0> translate<10.770000,0.000000,40.710000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.770000,0.000000,40.710000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.470000,0.000000,40.710000>}
box{<0,0,-0.101600><6.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.470000,0.000000,40.710000> }
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,10.922000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.050000,0.000000,10.922000>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.970000,0.000000,10.922000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.050000,0.000000,10.922000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.050000,0.000000,10.160000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,-90.000000,0> translate<19.050000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.050000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.050000,0.000000,9.398000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,-90.000000,0> translate<19.050000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.050000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,9.398000>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.970000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,10.160000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,90.000000,0> translate<13.970000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,10.922000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,90.000000,0> translate<13.970000,0.000000,10.922000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.050000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.304000,0.000000,10.160000>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,0.000000,0> translate<19.050000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.970000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.716000,0.000000,10.160000>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.716000,0.000000,10.160000> }
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.740000,0.000000,43.110000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.740000,0.000000,40.710000>}
box{<0,0,-0.101600><2.400000,0.036000,0.101600> rotate<0,-90.000000,0> translate<24.740000,0.000000,40.710000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.740000,0.000000,40.710000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.440000,0.000000,40.710000>}
box{<0,0,-0.101600><6.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<18.440000,0.000000,40.710000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.440000,0.000000,40.710000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.440000,0.000000,43.110000>}
box{<0,0,-0.101600><2.400000,0.036000,0.101600> rotate<0,90.000000,0> translate<18.440000,0.000000,43.110000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.440000,0.000000,43.110000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.740000,0.000000,43.110000>}
box{<0,0,-0.101600><6.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<18.440000,0.000000,43.110000> }
//S1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.652000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,10.668000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.398000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.652000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.652000,0.000000,12.192000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.652000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.652000,0.000000,12.192000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.398000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,13.970000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.398000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,12.192000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.048000,0.000000,12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,10.668000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.048000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,10.668000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.048000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,14.478000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<8.890000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,8.890000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.890000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,10.414000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.398000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,13.970000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.302000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,12.446000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.302000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,8.890000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<3.302000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,10.414000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.302000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,10.160000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,-90.000000,0> translate<5.080000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,10.160000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<5.080000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,12.700000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,90.000000,0> translate<7.620000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,12.700000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<5.080000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,14.224000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<5.080000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,14.224000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<5.080000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,14.478000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,90.000000,0> translate<7.620000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.493000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,8.636000>}
box{<0,0,-0.025400><2.413000,0.036000,0.025400> rotate<0,0.000000,0> translate<5.080000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.493000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.493000,0.000000,8.382000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<7.493000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.080000,0.000000,8.382000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<5.080000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.509000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,8.382000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.191000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,14.478000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,14.478000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.509000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,14.478000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,14.478000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,14.478000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.191000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.493000,0.000000,8.382000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.493000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,8.382000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.493000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,12.446000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.398000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.302000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.302000,0.000000,12.446000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.302000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,9.271000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,9.271000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,9.271000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,13.716000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,11.938000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.937000,0.000000,11.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,10.922000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,10.160000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.937000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,11.938000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,11.049000>}
box{<0,0,-0.076200><0.924574,0.036000,0.076200> rotate<0,74.049717,0> translate<3.937000,0.000000,11.938000> }
difference{
cylinder{<6.350000,0,11.430000><6.350000,0.036000,11.430000>1.854200 translate<0,0.000000,0>}
cylinder{<6.350000,-0.1,11.430000><6.350000,0.135000,11.430000>1.701800 translate<0,0.000000,0>}}
difference{
cylinder{<4.191000,0,9.271000><4.191000,0.036000,9.271000>0.584200 translate<0,0.000000,0>}
cylinder{<4.191000,-0.1,9.271000><4.191000,0.135000,9.271000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<8.509000,0,9.398000><8.509000,0.036000,9.398000>0.584200 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,9.398000><8.509000,0.135000,9.398000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<8.509000,0,13.589000><8.509000,0.036000,13.589000>0.584200 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,13.589000><8.509000,0.135000,13.589000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<4.191000,0,13.589000><4.191000,0.036000,13.589000>0.584200 translate<0,0.000000,0>}
cylinder{<4.191000,-0.1,13.589000><4.191000,0.135000,13.589000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<6.350000,0,11.430000><6.350000,0.036000,11.430000>0.660400 translate<0,0.000000,0>}
cylinder{<6.350000,-0.1,11.430000><6.350000,0.135000,11.430000>0.609600 translate<0,0.000000,0>}}
difference{
cylinder{<6.350000,0,11.430000><6.350000,0.036000,11.430000>0.330200 translate<0,0.000000,0>}
cylinder{<6.350000,-0.1,11.430000><6.350000,0.135000,11.430000>0.177800 translate<0,0.000000,0>}}
//SUP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,32.385000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<55.880000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,33.020000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<55.880000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,32.385000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<57.785000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,28.575000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<55.880000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,29.845000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<55.880000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,30.480000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<55.880000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,29.845000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<57.785000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,28.575000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<58.420000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,27.940000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<57.785000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,30.480000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<55.880000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,31.115000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<57.785000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,31.115000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<58.420000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,24.765000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<55.880000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,25.400000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<55.880000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,24.765000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<57.785000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,26.035000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<55.880000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,27.305000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<55.880000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,27.940000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<55.880000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,27.305000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<57.785000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,26.035000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<58.420000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,25.400000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<57.785000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,22.860000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<56.515000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.880000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,22.860000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<55.880000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,23.495000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<57.785000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.420000,0.000000,23.495000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<58.420000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.785000,0.000000,33.020000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<56.515000,0.000000,33.020000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<57.150000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<57.150000,0.000000,29.210000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<57.150000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<57.150000,0.000000,24.130000>}
//U$1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,33.401000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.670000,0.000000,33.401000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,27.559000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.670000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,27.559000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.070000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,31.496000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.670000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,29.464000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.670000,0.000000,29.464000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<26.670000,0.000000,30.480000>}
//Y1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.166000,0.000000,13.081000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.166000,0.000000,19.939000>}
box{<0,0,-0.101600><6.858000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.166000,0.000000,19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.594000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.594000,0.000000,13.081000>}
box{<0,0,-0.101600><6.858000,0.036000,0.101600> rotate<0,-90.000000,0> translate<53.594000,0.000000,13.081000> }
object{ARC(2.286000,0.203200,0.000000,180.000000,0.036000) translate<55.880000,0.000000,19.939000>}
object{ARC(2.286000,0.203200,180.000000,360.000000,0.036000) translate<55.880000,0.000000,13.081000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  MASTERBOARD(-29.235500,0,-30.475000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//BTM8	BLUETOOTH_MATE_SILVER	BLUETOOTH_MATE_90FEMALE
//C1	10uF	CPOL-RADIAL-10UF-25V
//C2	10uF	CPOL-RADIAL-10UF-25V
//C3	0.1uF	CAP-PTH-SMALL
//C4	0.1uF	CAP-PTH-SMALL
//C5	22Pf	CAP-PTH-SMALL
//C6	22pF	CAP-PTH-SMALL
//C7	10uF	CPOL-RADIAL-10UF-25V
//C8	0.1uF	CAP-PTH-SMALL
//C9	0.1uF	CAP-PTH-SMALL
//C10	100uF	CPOL-RADIAL-10UF-25V
//C11	0.1uF	CAP-PTH-SMALL
//C12	0.1uF	CAP-PTH-SMALL
//D1		DIODE-1N4148
//I2C_A		MOLEX-1X6_LOCK
//I2C_B		MOLEX-1X6_LOCK
//I2C_C		MOLEX-1X6_LOCK
//I2C_X1		MOLEX-1X6_LOCK
//IC2	MCP1700	TO92-INLINE
//JP1	VCC	MOLEX-1X2_LOCK
//JP2	V+	MOLEX-1X2_LOCK
//JP4	FTDI	FTDI_BASIC
//JP5	STAND-OFF	STAND-OFF
//JP6	SPKR	MOLEX-1X2_LOCK
//JP7	STAND-OFF	STAND-OFF
//JP8	STAND-OFF	STAND-OFF
//JP9	STAND-OFF	STAND-OFF
//JP10	GND	1X09_LOCK
//JP11	VCC	1X09_LOCK
//JP12	DIO2	1X05_LOCK
//JP13	3V3	1X03_LOCK
//JP15	DIO	1X04_LOCK
//R1	220	AXIAL-0.4
//R2	10K	AXIAL-0.3
//R3	1K5	AXIAL-0.4
//SUP1	DIO	1X04_LOCK
//Y1	16MHz	HC49US
