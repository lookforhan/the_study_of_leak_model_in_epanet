function [ output_args ] = EPS_SIM( input_file )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
disp('EPS_SIM:begin');
value=libpointer('singlePtr',0);%ָ�����--ֵ
id = libpointer('cstring','node_id_k');
loadlibrary('epanet2.dll','epanet2.h'); %����EPA��̬���ӿ�
code1=calllib('epanet2','ENopen',input_file,'1.rpt','1.out');% �򿪹��������ļ�
if code1~=0
    output_args = 1;
    disp(['EPS_SIM:���ö�̬���ӿ���󣬴������',num2str(code1)]);
    return
end
calllib('epanet2','ENopenH');
calllib('epanet2','ENinitH',1);
temp_t =0;
temp_tstep =1;
time_step_n=0;
while temp_tstep
    [errcode,temp_t]=calllib('epanet2','ENrunH',temp_t);%����
    [errcode,temp_tstep]=calllib('epanet2','ENnextH',temp_tstep);
end
code1=calllib('epanet2','ENsetreport','NODES ALL');
if code1~=0
    output_args = 1;
    disp(['EPS_SIM:���ö�̬���ӿ���󣬴������',num2str(code1)]);
    return
end
code1=calllib('epanet2','ENsaveH');
if code1~=0
    output_args = 1;
    disp(['EPS_SIM:���ö�̬���ӿ���󣬴������',num2str(code1)]);
    return
end
code1=calllib('epanet2','ENreport');
if code1~=0
    output_args = 1;
    disp(['EPS_SIM:���ö�̬���ӿ���󣬴������',num2str(code1)]);
    return
end

disp('EPS_SIM:end');
output_args = 0;
end

