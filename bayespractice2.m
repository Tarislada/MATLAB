%% ����������� escape�� Ƚ���� ���� avoid �� Ȯ��
% �ش� �׷��� ������ n �߿� ���� avoid�� �� Ƚ��
function [tmpcell,resultmat] = bayespractice2(avescmat,divind)
       
        session_num = diff(divind);
        startidx = divind(1:end-1);
        subject_num = length(startidx);
        tmpcell = cell(3,subject_num);
        
        for i = 1:subject_num
            tmpmat = avescmat(:,startidx(i):startidx(i)+session_num(i));
            tmpvec = tmpmat(~isnan(tmpmat));
            tmpcell{1,i} = tmpvec;
            tmpcell{2,i} = sum(tmpvec);
            % total number of avoidance events
            tmpcell{3,i} = length(tmpvec) - sum(tmpvec);
            % total number of escape events
            tmpcell{4,i} = length(tmpvec);
            % total number of either events
        end
        maxescape = cellfun(@max,tmpcell(3,:));
        row1mat = zeros(subject_num,max(maxescape));
        row2mat = zeros(subject_num,max(maxescape));
        
        for i = 1:subject_num
            workvec = tmpcell{1,i};
            zeroidx = find(workvec==0);
            zeroidx = zeroidx+1;
            zeroidx = zeroidx(zeroidx<=length(workvec));
            
            aftescvec = workvec(zeroidx);
            row1mat(i,1:length(aftescvec)) = aftescvec;
                        
            escapenum = tmpcell{3,i};
            row2mat(i,1:escapenum) = 1;
            
        end
        resultmat = [1:max(maxescape);sum(row1mat,1);sum(row2mat,1)];
end        

