function writeXML(cameraParams,file)
%writeXML(cameraParams,file)
%功能：将相机校正的参数保存为xml文件
%输入：
%cameraParams：相机校正数据结构
%file：xml文件名
%说明在xml文件是由一层层的节点组成的。
%首先创建父节点 fatherNode，
%然后创建子节点 childNode=docNode.createElement(childNodeName)，
%再将子节点添加到父节点 fatherNode.appendChild(childNode)
docNode = com.mathworks.xml.XMLUtils.createDocument('opencv_storage'); %创建xml文件对象
docRootNode = docNode.getDocumentElement; %获取根节点

IntrinsicMatrix = (cameraParams.IntrinsicMatrix)'; %相机内参矩阵
RadialDistortion = cameraParams.RadialDistortion; %相机径向畸变参数向量1*3
TangentialDistortion =cameraParams.TangentialDistortion; %相机切向畸变向量1*2
Distortion = [RadialDistortion(1:2),TangentialDistortion,RadialDistortion(3)]; %构成opencv中的畸变系数向量[k1,k2,p1,p2,k3]

camera_matrix = docNode.createElement('camera-matrix'); %创建mat节点
camera_matrix.setAttribute('type_id','opencv-matrix'); %设置mat节点属性
rows = docNode.createElement('rows'); %创建行节点
rows.appendChild(docNode.createTextNode(sprintf('%d',3))); %创建文本节点，并作为行的子节点
camera_matrix.appendChild(rows); %将行节点作为mat子节点

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