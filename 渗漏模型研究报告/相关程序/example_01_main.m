clear;clc;close all;tic
% rmdir(output_net_filename,'s')
input_net_filename = 'C:\Users\hc042\Desktop\渗漏模型研究报告\案例一\example_01.inp';
input_damage_filename='C:\Users\hc042\Desktop\渗漏模型研究报告\案例一\example_01_damage.txt';
output_net_filename=['C:\Users\hc042\Desktop\计算结果','\111',];
if exist(output_net_filename,'dir')
%     rmdir(output_net_filename,'s')
end

%% 读入原始管网
path('C:\Users\hc042\Desktop\renxingjisuancode2\readNet',path);
loadlibrary('epanet2.dll','epanet2.h'); %加载EPA动态链接库
[ t_read,net_data ] = read_net( input_net_filename);
if t_read ~=0
    disp('errors==================');
    disp('generate_damage_inp');
    disp('line 5')
    output_args=1;
    return
end
%%
load EPA_F
path('C:\Users\hc042\Desktop\renxingjisuancode2\damageNet',path);

%%
[t_e,damage_pipe_info]=ND_Execut_deterministic(net_data,input_damage_filename);%调用ND_Execut子程序生成破坏信息
if t_e ~= 0
    disp('errors==================');
    disp('generate_damage_inp');
    disp('line 19')
    disp('出错')
    output_args=2;
    return
end
%%

mkdir (output_net_filename);
MC_simulate_result_dir=output_net_filename;
if ~isempty(damage_pipe_info{1})
    output_net_filename_inp_ER=[MC_simulate_result_dir,'\damage_net_ER','.inp'];%第i次模拟输出管网inp文件
    output_net_filename_inp_NS=[MC_simulate_result_dir,'\damage_net_NS','.inp'];%第i次模拟输出管网inp文件
    output_net_filename_inp_GIRAFFE=[MC_simulate_result_dir,'\damage_net_GIRAFFE','.inp'];%第i次模拟输出管网inp文件
    output_net_filename_inp_GIRAFFE2=[MC_simulate_result_dir,'\damage_net_GIRAFFE2','.inp'];%第i次模拟输出管网inp文件
%     [~,~]=damageNetInp2_E_R(net_data,damage_pipe_info,EPA_format,output_net_filename_inp_ER);
%     [t_W,pipe_relative]=damageNetInp2_N_S(net_data,damage_pipe_info,EPA_format,output_net_filename_inp_NS);
%     [~,~]=damageNetInp2_GIRAFFE(net_data,damage_pipe_info,EPA_format,output_net_filename_inp_GIRAFFE);
    [~,~]=damageNetInp2_GIRAFFE2(net_data,damage_pipe_info,EPA_format,output_net_filename_inp_GIRAFFE2);
    %%
    BreakPipe_order=num2cell(damage_pipe_info{1});
else
    disp('no damage');
    return
end

% loadlibrary('epanet2.dll','epanet2.h'); %加载EPA动态链接库
% code1=calllib('epanet2','ENopen',output_net_filename_inp_NS,'1.rpt','1.out');% 打开管网数据文件
% code2=calllib('epanet2','ENsolveH');
% value=libpointer('singlePtr',0);%指针参数--值
% id = libpointer('cstring','node_id_k');
% [code21,value]=calllib('epanet2','ENgetnodevalue',2,11,value);
% [code22,id]=calllib('epanet2','ENgetnodeid',2,id);
% 
% code3=calllib('epanet2','ENsetreport','NODES ALL');
% code4=calllib('epanet2','ENsaveH');
% code5=calllib('epanet2','ENreport');
% code6=calllib('epanet2','ENclose');
% rmdir(output_net_filename,'s')