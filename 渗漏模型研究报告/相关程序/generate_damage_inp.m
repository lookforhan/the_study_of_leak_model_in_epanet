function [ output_args ] = generate_damage_inp( input_net_filename,input_damage_filename,output_net_filename )
%UNTITLED2 根据破坏信息生成四种渗漏模型的管网inp文件
%   input_net_filename：管网文件地址
%   input_damage_filename：破坏信息
%   output_net_filename：生成文件存放目录
disp('generate_damage_inp:开始')
%% 读入原始管网
path('C:\Users\hc042\Desktop\renxingjisuancode2\readNet',path);
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
    [~,~]=damageNetInp2_E_R(net_data,damage_pipe_info,EPA_format,output_net_filename_inp_ER);
    [t_W,pipe_relative]=damageNetInp2_N_S(net_data,damage_pipe_info,EPA_format,output_net_filename_inp_NS);
    [~,~]=damageNetInp2_GIRAFFE(net_data,damage_pipe_info,EPA_format,output_net_filename_inp_GIRAFFE);
    [~,~]=damageNetInp2_GIRAFFE2(net_data,damage_pipe_info,EPA_format,output_net_filename_inp_GIRAFFE2);
    %%
    BreakPipe_order=num2cell(damage_pipe_info{1});
else
    disp('no damage');
    return
end
disp('generate_damage_inp:结束')
output_args=0;
end

