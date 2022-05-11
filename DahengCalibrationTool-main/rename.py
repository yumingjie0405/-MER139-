# 此代码是将指定文件夹目录下的所有文件重命名，想单独对单一类型文件重命名时要么加判断语句，要么指定文件夹下只存放同类型文件。
import os
#from utils import mkdir
#TODO   
path = r"C:\Users\smile\Desktop\相机标定\DahengCalibrationTool-main\image"  # 指定文件夹
filelist = os.listdir(path)  # 该文件夹下所有的文件（包括文件夹）
count = 0  # 从0开始重新对所有文件命名

for file in filelist:   # 遍历所有文件
    print(file)
    Olddir = os.path.join(path, file)   # 原来的文件路径
    if os.path.isdir(Olddir):   # 如果是文件夹则跳过
        continue
    filename = os.path.splitext(file)[0]   # 文件名
    filetype = os.path.splitext(file)[1]   # 文件扩展名（这里如果想针对文件夹单独一种类型重命名，则加判断语句即可）
    Newdir = os.path.join(path, str(count).zfill(5) + filetype)  # 用字符串函数zfill 以0补全所需位数
    os.rename(Olddir,Newdir)  # 重命名并储存
    count += 1


  
#TODO 存放标签的路径
txtsavepath = r'C:\Users\smile\Desktop\相机标定\DahengCalibrationTool-main\image\txt'
os.mkdir(txtsavepath)
#mkdir(picsavepath)
# 得到所有xml的数目
total_xml = os.listdir(path) 
num = len(total_xml)

ftrainval = open(txtsavepath+'/trainval.txt', 'w')
for i in range(num-1):
    #TODO
    name = "/home/ymj/Pictures/image/"+total_xml[i][:-4]+".bmp"+'\n'
    ftrainval.write(name)
ftrainval.close()
