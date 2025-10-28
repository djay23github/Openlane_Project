module pmu_fsm (clk,
    clk_gate_en,
    clk_stable,
    error,
    pwr_gate_en,
    pwr_stable,
    req_idle,
    req_off,
    req_sleep,
    reset_ctrl,
    reset_n,
    retention_en,
    retention_ready,
    retention_restore,
    retention_save,
    seq_busy,
    wake_up,
    dvfs_ctrl,
    pwr_state);
 input clk;
 output clk_gate_en;
 input clk_stable;
 output error;
 output pwr_gate_en;
 input pwr_stable;
 input req_idle;
 input req_off;
 input req_sleep;
 output reset_ctrl;
 input reset_n;
 output retention_en;
 input retention_ready;
 output retention_restore;
 output retention_save;
 output seq_busy;
 input wake_up;
 output [1:0] dvfs_ctrl;
 output [1:0] pwr_state;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire _091_;
 wire _092_;
 wire _093_;
 wire _094_;
 wire _095_;
 wire _096_;
 wire _097_;
 wire _098_;
 wire _099_;
 wire _100_;
 wire _101_;
 wire _102_;
 wire _103_;
 wire _104_;
 wire _105_;
 wire _106_;
 wire _107_;
 wire _108_;
 wire _109_;
 wire _110_;
 wire _111_;
 wire _112_;
 wire _113_;
 wire _114_;
 wire _115_;
 wire _116_;
 wire \curr_state[0] ;
 wire \curr_state[1] ;
 wire \curr_state[2] ;
 wire \next_state[0] ;
 wire \next_state[1] ;
 wire \next_state[2] ;
 wire req_idle_sync;
 wire req_off_sync;
 wire req_sleep_sync;
 wire \seq_timer[0] ;
 wire \seq_timer[1] ;
 wire \seq_timer[2] ;
 wire \seq_timer[3] ;
 wire \seq_timer[4] ;
 wire \seq_timer[5] ;
 wire \seq_timer[6] ;
 wire \seq_timer[7] ;
 wire \sync_stage1[0] ;
 wire \sync_stage1[1] ;
 wire \sync_stage1[2] ;
 wire \sync_stage1[3] ;
 wire wake_up_sync;
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net19;
 wire net20;
 wire net21;

 sky130_fd_sc_hd__nor2_1 _117_ (.A(\seq_timer[3] ),
    .B(\seq_timer[2] ),
    .Y(_057_));
 sky130_fd_sc_hd__nand2_1 _118_ (.A(\seq_timer[1] ),
    .B(\seq_timer[0] ),
    .Y(_058_));
 sky130_fd_sc_hd__nand2_1 _119_ (.A(_057_),
    .B(_058_),
    .Y(_059_));
 sky130_fd_sc_hd__nor2_1 _120_ (.A(\seq_timer[5] ),
    .B(\seq_timer[4] ),
    .Y(_060_));
 sky130_fd_sc_hd__nor2_1 _121_ (.A(\seq_timer[6] ),
    .B(\seq_timer[7] ),
    .Y(_061_));
 sky130_fd_sc_hd__nand2_1 _122_ (.A(_060_),
    .B(_061_),
    .Y(_062_));
 sky130_fd_sc_hd__nor2_1 _123_ (.A(_059_),
    .B(_062_),
    .Y(_063_));
 sky130_fd_sc_hd__inv_6 _124_ (.A(\curr_state[2] ),
    .Y(_064_));
 sky130_fd_sc_hd__nor2_1 _125_ (.A(\curr_state[0] ),
    .B(_064_),
    .Y(_065_));
 sky130_fd_sc_hd__clkbuf_2 _126_ (.A(\curr_state[1] ),
    .X(_066_));
 sky130_fd_sc_hd__nand2_1 _127_ (.A(_065_),
    .B(_066_),
    .Y(_067_));
 sky130_fd_sc_hd__inv_2 _128_ (.A(_067_),
    .Y(_068_));
 sky130_fd_sc_hd__nand2_1 _129_ (.A(_063_),
    .B(_068_),
    .Y(_069_));
 sky130_fd_sc_hd__inv_2 _130_ (.A(\seq_timer[1] ),
    .Y(_070_));
 sky130_fd_sc_hd__inv_2 _131_ (.A(\seq_timer[0] ),
    .Y(_071_));
 sky130_fd_sc_hd__nand2_1 _132_ (.A(_070_),
    .B(_071_),
    .Y(_072_));
 sky130_fd_sc_hd__inv_2 _133_ (.A(\seq_timer[3] ),
    .Y(_073_));
 sky130_fd_sc_hd__nand3_1 _134_ (.A(_060_),
    .B(_061_),
    .C(_073_),
    .Y(_074_));
 sky130_fd_sc_hd__or3_1 _135_ (.A(\seq_timer[2] ),
    .B(_072_),
    .C(_074_),
    .X(_075_));
 sky130_fd_sc_hd__inv_2 _136_ (.A(_075_),
    .Y(_076_));
 sky130_fd_sc_hd__nor2_1 _137_ (.A(_069_),
    .B(_076_),
    .Y(_114_));
 sky130_fd_sc_hd__nand2_1 _138_ (.A(\curr_state[0] ),
    .B(\curr_state[1] ),
    .Y(_077_));
 sky130_fd_sc_hd__inv_2 _139_ (.A(_077_),
    .Y(_078_));
 sky130_fd_sc_hd__nor2_1 _140_ (.A(_064_),
    .B(_078_),
    .Y(net18));
 sky130_fd_sc_hd__inv_2 _141_ (.A(req_off_sync),
    .Y(_079_));
 sky130_fd_sc_hd__o21a_1 _142_ (.A1(\curr_state[2] ),
    .A2(_079_),
    .B1(_077_),
    .X(_080_));
 sky130_fd_sc_hd__inv_2 _143_ (.A(\curr_state[0] ),
    .Y(_081_));
 sky130_fd_sc_hd__inv_2 _144_ (.A(req_idle_sync),
    .Y(_082_));
 sky130_fd_sc_hd__nand2_1 _145_ (.A(_081_),
    .B(_082_),
    .Y(_083_));
 sky130_fd_sc_hd__nor2_1 _146_ (.A(\curr_state[2] ),
    .B(_066_),
    .Y(_084_));
 sky130_fd_sc_hd__inv_2 _147_ (.A(req_sleep_sync),
    .Y(_085_));
 sky130_fd_sc_hd__nand3_1 _148_ (.A(_083_),
    .B(_084_),
    .C(_085_),
    .Y(_086_));
 sky130_fd_sc_hd__nand2_1 _149_ (.A(_080_),
    .B(_086_),
    .Y(_087_));
 sky130_fd_sc_hd__inv_2 _150_ (.A(wake_up_sync),
    .Y(_088_));
 sky130_fd_sc_hd__nand2_1 _151_ (.A(_087_),
    .B(_088_),
    .Y(_089_));
 sky130_fd_sc_hd__nor2_1 _152_ (.A(_066_),
    .B(_064_),
    .Y(_090_));
 sky130_fd_sc_hd__nand2_1 _153_ (.A(_090_),
    .B(\curr_state[0] ),
    .Y(_091_));
 sky130_fd_sc_hd__nand2_1 _154_ (.A(_089_),
    .B(_091_),
    .Y(_092_));
 sky130_fd_sc_hd__nand2_1 _155_ (.A(_078_),
    .B(\curr_state[2] ),
    .Y(_093_));
 sky130_fd_sc_hd__nand2_1 _156_ (.A(_092_),
    .B(_093_),
    .Y(_094_));
 sky130_fd_sc_hd__inv_2 _157_ (.A(_094_),
    .Y(\next_state[0] ));
 sky130_fd_sc_hd__nand2_1 _158_ (.A(net2),
    .B(net1),
    .Y(_095_));
 sky130_fd_sc_hd__o21bai_1 _159_ (.A1(_059_),
    .A2(_062_),
    .B1_N(_095_),
    .Y(_096_));
 sky130_fd_sc_hd__nand2_1 _160_ (.A(_096_),
    .B(_068_),
    .Y(_097_));
 sky130_fd_sc_hd__nand2_1 _161_ (.A(\seq_timer[3] ),
    .B(\seq_timer[2] ),
    .Y(_098_));
 sky130_fd_sc_hd__nor2_1 _162_ (.A(_058_),
    .B(_098_),
    .Y(_099_));
 sky130_fd_sc_hd__nor2_1 _163_ (.A(_062_),
    .B(_099_),
    .Y(_100_));
 sky130_fd_sc_hd__inv_2 _164_ (.A(net6),
    .Y(_101_));
 sky130_fd_sc_hd__nand3_1 _165_ (.A(_100_),
    .B(_101_),
    .C(_068_),
    .Y(_102_));
 sky130_fd_sc_hd__nand2_1 _166_ (.A(_097_),
    .B(_102_),
    .Y(_103_));
 sky130_fd_sc_hd__a21oi_1 _167_ (.A1(\seq_timer[2] ),
    .A2(_072_),
    .B1(_074_),
    .Y(_104_));
 sky130_fd_sc_hd__nor2_1 _168_ (.A(_101_),
    .B(_063_),
    .Y(_105_));
 sky130_fd_sc_hd__inv_2 _169_ (.A(\curr_state[1] ),
    .Y(_106_));
 sky130_fd_sc_hd__and2_1 _170_ (.A(_065_),
    .B(_106_),
    .X(_107_));
 sky130_fd_sc_hd__nand2_1 _171_ (.A(_105_),
    .B(_107_),
    .Y(_108_));
 sky130_fd_sc_hd__o21ai_1 _172_ (.A1(_091_),
    .A2(_104_),
    .B1(_108_),
    .Y(_109_));
 sky130_fd_sc_hd__o311a_1 _173_ (.A1(\curr_state[0] ),
    .A2(wake_up_sync),
    .A3(_079_),
    .B1(_064_),
    .C1(_066_),
    .X(_110_));
 sky130_fd_sc_hd__or3_1 _174_ (.A(_103_),
    .B(_109_),
    .C(_110_),
    .X(_111_));
 sky130_fd_sc_hd__clkbuf_1 _175_ (.A(_111_),
    .X(\next_state[1] ));
 sky130_fd_sc_hd__nand2_1 _176_ (.A(_100_),
    .B(_107_),
    .Y(_012_));
 sky130_fd_sc_hd__nor2_1 _177_ (.A(_012_),
    .B(_105_),
    .Y(_013_));
 sky130_fd_sc_hd__nor2_1 _178_ (.A(_013_),
    .B(_103_),
    .Y(_014_));
 sky130_fd_sc_hd__inv_2 _179_ (.A(_091_),
    .Y(_015_));
 sky130_fd_sc_hd__nand2_1 _180_ (.A(_064_),
    .B(_066_),
    .Y(_016_));
 sky130_fd_sc_hd__nand2_1 _181_ (.A(_079_),
    .B(_085_),
    .Y(_017_));
 sky130_fd_sc_hd__nand3_1 _182_ (.A(_017_),
    .B(_084_),
    .C(_088_),
    .Y(_018_));
 sky130_fd_sc_hd__nor2_1 _183_ (.A(\curr_state[2] ),
    .B(_106_),
    .Y(_002_));
 sky130_fd_sc_hd__nand3_1 _184_ (.A(_002_),
    .B(_081_),
    .C(req_off_sync),
    .Y(_019_));
 sky130_fd_sc_hd__o211ai_2 _185_ (.A1(_088_),
    .A2(_016_),
    .B1(_018_),
    .C1(_019_),
    .Y(_020_));
 sky130_fd_sc_hd__a21oi_1 _186_ (.A1(_104_),
    .A2(_015_),
    .B1(_020_),
    .Y(_021_));
 sky130_fd_sc_hd__nand2_1 _187_ (.A(_014_),
    .B(_021_),
    .Y(\next_state[2] ));
 sky130_fd_sc_hd__o21a_1 _188_ (.A1(\curr_state[0] ),
    .A2(_066_),
    .B1(_064_),
    .X(_000_));
 sky130_fd_sc_hd__nor2_1 _189_ (.A(\curr_state[0] ),
    .B(_016_),
    .Y(_022_));
 sky130_fd_sc_hd__inv_2 _190_ (.A(_022_),
    .Y(_001_));
 sky130_fd_sc_hd__a21oi_1 _191_ (.A1(\curr_state[2] ),
    .A2(_066_),
    .B1(_081_),
    .Y(_112_));
 sky130_fd_sc_hd__nor2_1 _192_ (.A(\curr_state[2] ),
    .B(_077_),
    .Y(_023_));
 sky130_fd_sc_hd__nor2_1 _193_ (.A(_022_),
    .B(_107_),
    .Y(_024_));
 sky130_fd_sc_hd__or3b_1 _194_ (.A(_015_),
    .B(_023_),
    .C_N(_024_),
    .X(_025_));
 sky130_fd_sc_hd__clkbuf_1 _195_ (.A(_025_),
    .X(_113_));
 sky130_fd_sc_hd__a21o_1 _196_ (.A1(_076_),
    .A2(_068_),
    .B1(_023_),
    .X(_115_));
 sky130_fd_sc_hd__o21ai_1 _197_ (.A1(_069_),
    .A2(_076_),
    .B1(_024_),
    .Y(_116_));
 sky130_fd_sc_hd__o211a_1 _198_ (.A1(_070_),
    .A2(\seq_timer[0] ),
    .B1(_090_),
    .C1(_063_),
    .X(_003_));
 sky130_fd_sc_hd__nand2_1 _199_ (.A(_065_),
    .B(_101_),
    .Y(_026_));
 sky130_fd_sc_hd__a211oi_1 _200_ (.A1(_066_),
    .A2(_095_),
    .B1(_026_),
    .C1(_100_),
    .Y(net10));
 sky130_fd_sc_hd__or2_1 _201_ (.A(\seq_timer[0] ),
    .B(net20),
    .X(_027_));
 sky130_fd_sc_hd__nand2_1 _202_ (.A(net20),
    .B(\seq_timer[0] ),
    .Y(_028_));
 sky130_fd_sc_hd__nand2_1 _203_ (.A(_027_),
    .B(_028_),
    .Y(_029_));
 sky130_fd_sc_hd__nand3_1 _204_ (.A(_014_),
    .B(\curr_state[2] ),
    .C(_021_),
    .Y(_030_));
 sky130_fd_sc_hd__inv_2 _205_ (.A(_020_),
    .Y(_031_));
 sky130_fd_sc_hd__nand2_1 _206_ (.A(_094_),
    .B(_081_),
    .Y(_032_));
 sky130_fd_sc_hd__nand3_1 _207_ (.A(_092_),
    .B(\curr_state[0] ),
    .C(_093_),
    .Y(_033_));
 sky130_fd_sc_hd__nand2_1 _208_ (.A(_032_),
    .B(_033_),
    .Y(_034_));
 sky130_fd_sc_hd__nand3_4 _209_ (.A(_030_),
    .B(_031_),
    .C(_034_),
    .Y(_035_));
 sky130_fd_sc_hd__nor2_1 _210_ (.A(_029_),
    .B(_035_),
    .Y(_004_));
 sky130_fd_sc_hd__or2_1 _211_ (.A(_070_),
    .B(_028_),
    .X(_036_));
 sky130_fd_sc_hd__nand2_1 _212_ (.A(_028_),
    .B(_070_),
    .Y(_037_));
 sky130_fd_sc_hd__nand2_1 _213_ (.A(_036_),
    .B(_037_),
    .Y(_038_));
 sky130_fd_sc_hd__nor2_1 _214_ (.A(_038_),
    .B(_035_),
    .Y(_005_));
 sky130_fd_sc_hd__inv_2 _215_ (.A(\seq_timer[2] ),
    .Y(_039_));
 sky130_fd_sc_hd__or2_1 _216_ (.A(_039_),
    .B(_036_),
    .X(_040_));
 sky130_fd_sc_hd__nand2_1 _217_ (.A(_036_),
    .B(_039_),
    .Y(_041_));
 sky130_fd_sc_hd__nand2_1 _218_ (.A(_040_),
    .B(_041_),
    .Y(_042_));
 sky130_fd_sc_hd__nor2_1 _219_ (.A(_042_),
    .B(_035_),
    .Y(_006_));
 sky130_fd_sc_hd__nand2_1 _220_ (.A(_040_),
    .B(_073_),
    .Y(_043_));
 sky130_fd_sc_hd__or2_1 _221_ (.A(_098_),
    .B(_036_),
    .X(_044_));
 sky130_fd_sc_hd__nand2_1 _222_ (.A(_043_),
    .B(_044_),
    .Y(_045_));
 sky130_fd_sc_hd__nor2_1 _223_ (.A(_045_),
    .B(_035_),
    .Y(_007_));
 sky130_fd_sc_hd__nand2b_1 _224_ (.A_N(\seq_timer[4] ),
    .B(_044_),
    .Y(_046_));
 sky130_fd_sc_hd__nand3_1 _225_ (.A(net20),
    .B(\seq_timer[4] ),
    .C(_099_),
    .Y(_047_));
 sky130_fd_sc_hd__nand2_1 _226_ (.A(_046_),
    .B(_047_),
    .Y(_048_));
 sky130_fd_sc_hd__nor2_1 _227_ (.A(_048_),
    .B(_035_),
    .Y(_008_));
 sky130_fd_sc_hd__inv_2 _228_ (.A(\seq_timer[5] ),
    .Y(_049_));
 sky130_fd_sc_hd__nor2_1 _229_ (.A(_049_),
    .B(_047_),
    .Y(_050_));
 sky130_fd_sc_hd__nand2_1 _230_ (.A(_047_),
    .B(_049_),
    .Y(_051_));
 sky130_fd_sc_hd__or2b_1 _231_ (.A(_050_),
    .B_N(_051_),
    .X(_052_));
 sky130_fd_sc_hd__nor2_1 _232_ (.A(_052_),
    .B(_035_),
    .Y(_009_));
 sky130_fd_sc_hd__or2_1 _233_ (.A(\seq_timer[6] ),
    .B(_050_),
    .X(_053_));
 sky130_fd_sc_hd__nand2_1 _234_ (.A(_050_),
    .B(\seq_timer[6] ),
    .Y(_054_));
 sky130_fd_sc_hd__nand2_1 _235_ (.A(_053_),
    .B(_054_),
    .Y(_055_));
 sky130_fd_sc_hd__nor2_1 _236_ (.A(_055_),
    .B(_035_),
    .Y(_010_));
 sky130_fd_sc_hd__xor2_1 _237_ (.A(\seq_timer[7] ),
    .B(_054_),
    .X(_056_));
 sky130_fd_sc_hd__nor2_1 _238_ (.A(_056_),
    .B(_035_),
    .Y(_011_));
 sky130_fd_sc_hd__dfstp_1 _239_ (.CLK(clk),
    .D(_001_),
    .SET_B(reset_n),
    .Q(net9));
 sky130_fd_sc_hd__dfrtp_1 _240_ (.CLK(clk),
    .D(_004_),
    .RESET_B(reset_n),
    .Q(\seq_timer[0] ));
 sky130_fd_sc_hd__dfrtp_1 _241_ (.CLK(clk),
    .D(_005_),
    .RESET_B(reset_n),
    .Q(\seq_timer[1] ));
 sky130_fd_sc_hd__dfrtp_1 _242_ (.CLK(clk),
    .D(_006_),
    .RESET_B(reset_n),
    .Q(\seq_timer[2] ));
 sky130_fd_sc_hd__dfrtp_1 _243_ (.CLK(clk),
    .D(_007_),
    .RESET_B(reset_n),
    .Q(\seq_timer[3] ));
 sky130_fd_sc_hd__dfrtp_1 _244_ (.CLK(clk),
    .D(_008_),
    .RESET_B(reset_n),
    .Q(\seq_timer[4] ));
 sky130_fd_sc_hd__dfrtp_1 _245_ (.CLK(clk),
    .D(_009_),
    .RESET_B(reset_n),
    .Q(\seq_timer[5] ));
 sky130_fd_sc_hd__dfrtp_1 _246_ (.CLK(clk),
    .D(_010_),
    .RESET_B(reset_n),
    .Q(\seq_timer[6] ));
 sky130_fd_sc_hd__dfrtp_1 _247_ (.CLK(clk),
    .D(_011_),
    .RESET_B(reset_n),
    .Q(\seq_timer[7] ));
 sky130_fd_sc_hd__dfrtp_1 _248_ (.CLK(clk),
    .D(_000_),
    .RESET_B(reset_n),
    .Q(net8));
 sky130_fd_sc_hd__dfrtp_1 _249_ (.CLK(clk),
    .D(_002_),
    .RESET_B(reset_n),
    .Q(net11));
 sky130_fd_sc_hd__dfrtp_1 _250_ (.CLK(clk),
    .D(_116_),
    .RESET_B(reset_n),
    .Q(net15));
 sky130_fd_sc_hd__dfrtp_1 _251_ (.CLK(clk),
    .D(_003_),
    .RESET_B(reset_n),
    .Q(net17));
 sky130_fd_sc_hd__dfrtp_1 _252_ (.CLK(clk),
    .D(_114_),
    .RESET_B(reset_n),
    .Q(net16));
 sky130_fd_sc_hd__dfrtp_1 _253_ (.CLK(clk),
    .D(_115_),
    .RESET_B(reset_n),
    .Q(net14));
 sky130_fd_sc_hd__dfrtp_1 _254_ (.CLK(clk),
    .D(_112_),
    .RESET_B(reset_n),
    .Q(net12));
 sky130_fd_sc_hd__dfrtp_1 _255_ (.CLK(clk),
    .D(_113_),
    .RESET_B(reset_n),
    .Q(net13));
 sky130_fd_sc_hd__dfrtp_4 _256_ (.CLK(clk),
    .D(\next_state[0] ),
    .RESET_B(reset_n),
    .Q(\curr_state[0] ));
 sky130_fd_sc_hd__dfrtp_1 _257_ (.CLK(clk),
    .D(\next_state[1] ),
    .RESET_B(reset_n),
    .Q(\curr_state[1] ));
 sky130_fd_sc_hd__dfrtp_4 _258_ (.CLK(clk),
    .D(\next_state[2] ),
    .RESET_B(reset_n),
    .Q(\curr_state[2] ));
 sky130_fd_sc_hd__dfrtp_1 _259_ (.CLK(clk),
    .D(net7),
    .RESET_B(reset_n),
    .Q(\sync_stage1[0] ));
 sky130_fd_sc_hd__dfrtp_1 _260_ (.CLK(clk),
    .D(net4),
    .RESET_B(reset_n),
    .Q(\sync_stage1[1] ));
 sky130_fd_sc_hd__dfrtp_1 _261_ (.CLK(clk),
    .D(net5),
    .RESET_B(reset_n),
    .Q(\sync_stage1[2] ));
 sky130_fd_sc_hd__dfrtp_1 _262_ (.CLK(clk),
    .D(net3),
    .RESET_B(reset_n),
    .Q(\sync_stage1[3] ));
 sky130_fd_sc_hd__dfrtp_1 _263_ (.CLK(clk),
    .D(\sync_stage1[0] ),
    .RESET_B(reset_n),
    .Q(wake_up_sync));
 sky130_fd_sc_hd__dfrtp_1 _264_ (.CLK(clk),
    .D(\sync_stage1[1] ),
    .RESET_B(reset_n),
    .Q(req_off_sync));
 sky130_fd_sc_hd__dfrtp_1 _265_ (.CLK(clk),
    .D(\sync_stage1[2] ),
    .RESET_B(reset_n),
    .Q(req_sleep_sync));
 sky130_fd_sc_hd__dfrtp_1 _266_ (.CLK(clk),
    .D(\sync_stage1[3] ),
    .RESET_B(reset_n),
    .Q(req_idle_sync));
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Right_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Right_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Right_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Right_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Right_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Right_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_39 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_40 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_41 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Left_42 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Left_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_67 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_91 ();
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(clk_stable),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(pwr_stable),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(req_idle),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(req_off),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(req_sleep),
    .X(net5));
 sky130_fd_sc_hd__buf_1 input6 (.A(retention_ready),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_1 input7 (.A(wake_up),
    .X(net7));
 sky130_fd_sc_hd__buf_4 output8 (.A(net8),
    .X(clk_gate_en));
 sky130_fd_sc_hd__clkbuf_2 output9 (.A(net9),
    .X(dvfs_ctrl[1]));
 sky130_fd_sc_hd__clkbuf_2 output10 (.A(net19),
    .X(error));
 sky130_fd_sc_hd__buf_4 output11 (.A(net11),
    .X(pwr_gate_en));
 sky130_fd_sc_hd__clkbuf_2 output12 (.A(net12),
    .X(pwr_state[0]));
 sky130_fd_sc_hd__clkbuf_2 output13 (.A(net13),
    .X(pwr_state[1]));
 sky130_fd_sc_hd__buf_2 output14 (.A(net14),
    .X(reset_ctrl));
 sky130_fd_sc_hd__buf_4 output15 (.A(net15),
    .X(retention_en));
 sky130_fd_sc_hd__buf_2 output16 (.A(net16),
    .X(retention_restore));
 sky130_fd_sc_hd__buf_2 output17 (.A(net17),
    .X(retention_save));
 sky130_fd_sc_hd__clkbuf_2 output18 (.A(net20),
    .X(seq_busy));
 sky130_fd_sc_hd__clkbuf_1 wire19 (.A(net10),
    .X(net19));
 sky130_fd_sc_hd__buf_1 wire20 (.A(net18),
    .X(net20));
 sky130_fd_sc_hd__conb_1 pmu_fsm_21 (.HI(net21));
 assign dvfs_ctrl[0] = net21;
endmodule
