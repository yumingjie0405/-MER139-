function writeXML(cameraParams,file)
%writeXML(cameraParams,file)
%���ܣ������У���Ĳ�������Ϊxml�ļ�
%���룺
%cameraParams�����У�����ݽṹ
%file��xml�ļ���
%˵����xml�ļ�����һ���Ľڵ���ɵġ�
%���ȴ������ڵ� fatherNode��
%Ȼ�󴴽��ӽڵ� childNode=docNode.createElement(childNodeName)��
%�ٽ��ӽڵ����ӵ����ڵ� fatherNode.appendChild(childNode)
docNode = com.mathworks.xml.XMLUtils.createDocument('opencv_storage'); %����xml�ļ�����
docRootNode = docNode.getDocumentElement; %��ȡ���ڵ�

IntrinsicMatrix = (cameraParams.IntrinsicMatrix)'; %����ڲξ���
RadialDistortion = cameraParams.RadialDistortion; %�����������������1*3
TangentialDistortion =cameraParams.TangentialDistortion; %��������������1*2
Distortion = [RadialDistortion(1:2),TangentialDistortion,RadialDistortion(3)]; %����opencv�еĻ���ϵ������[k1,k2,p1,p2,k3]

camera_matrix = docNode.createElement('camera-matrix'); %����mat�ڵ�
camera_matrix.setAttribute('type_id','opencv-matrix'); %����mat�ڵ�����
rows = docNode.createElement('rows'); %�����нڵ�
rows.appendChild(docNode.createTextNode(sprintf('%d',3))); %�����ı��ڵ㣬����Ϊ�е��ӽڵ�
camera_matrix.appendChild(rows); %���нڵ���Ϊmat�ӽڵ�

cols = docNode.createElement('cols');
cols.appendChild(docNode.createTextNode(sprintf('%d',3)));
camera_matrix.appendChild(cols);

dt = docNode.createElement('dt');
dt.appendChild(docNode.createTextNode('d'));
camera_matrix.appendChild(dt);

data = docNode.createElement('data');
for i=1:3
    for j=1:3
        data.appendChild(docNode.createTextNode(sprintf('%.16f ',IntrinsicMatrix(i,j))));
    end
    data.appendChild(docNode.createTextNode(sprintf('\n')));
end
camera_matrix.appendChild(data);
docRootNode.appendChild(camera_matrix);

distortion = docNode.createElement('distortion');
distortion.setAttribute('type_id','opencv-matrix');
rows = docNode.createElement('rows');
rows.appendChild(docNode.createTextNode(sprintf('%d',5)));
distortion.appendChild(rows);

cols = docNode.createElement('cols');
cols.appendChild(docNode.createTextNode(sprintf('%d',1)));
distortion.appendChild(cols);

dt = docNode.createElement('dt');
dt.appendChild(docNode.createTextNode('d'));
distortion.appendChild(dt);
data = docNode.createElement('data');
for i=1:5
      data.appendChild(docNode.createTextNode(sprintf('%.16f ',Distortion(i))));
end
distortion.appendChild(data);

docRootNode.appendChild(distortion);

xmlFileName = file;
xmlwrite(xmlFileName,docNode);
end