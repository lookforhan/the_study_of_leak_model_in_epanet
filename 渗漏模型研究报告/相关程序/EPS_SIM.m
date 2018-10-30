function [ output_args ] = EPS_SIM( input_file )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
disp('EPS_SIM:begin');
value=libpointer('singlePtr',0);%指针参数--值
id = libpointer('cstring','node_id_k');
loadlibrary('epanet2.dll','epanet2.h'); %加载EPA动态链接库
code1=calllib('epanet2','ENopen',input_file,'1.rpt','1.out');% 打开管网数据文件
if code1~=0
    output_args = 1;
    disp(['EPS_SIM:调用动态链接库错误，错误代码',num2str(code1)]);
    return
end
calllib('epanet2','ENopenH');
calllib('epanet2','ENinitH',1);
temp_t =0;
temp_tstep =1;
time_step_n=0;
while temp_tstep
    [errcode,temp_t]=calllib('epanet2','ENrunH',temp_t);%计算
    [errcode,temp_tstep]=calllib('epanet2','ENnextH',temp_tstep);
end
code1=calllib('epanet2','ENsetreport','NODES ALL');
if code1~=0
    output_args = 1;
    disp(['EPS_SIM:调用动态链接库错误，错误代码',num2str(code1)]);
    return
end
code1=calllib('epanet2','ENsaveH');
if code1~=0
    output_args = 1;
    disp(['EPS_SIM:调用动态链接库错误，错误代码',num2str(code1)]);
    return
end
code1=calllib('epanet2','ENreport');
if code1~=0
    output_args = 1;
    disp(['EPS_SIM:调用动态链接库错误，错误代码',num2str(code1)]);
    return
end

disp('EPS_SIM:end');
output_args = 0;
end

