package com.lj.test;

import com.lj.dao.UserDAO;
import com.lj.entity.User;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestPoi {

    @Resource
    private UserDAO userDAO;

    @Test
    public void testExport() throws Exception{

        List<User> users = userDAO.selectAll(0,10);
        //创建工作薄
        Workbook workbook = new HSSFWorkbook();
        //创建表
        Sheet sheet = workbook.createSheet("用户表");
        //设置单元格宽度
        sheet.setColumnWidth(3,15*256);
        //创建字体格式
        Font font = workbook.createFont();
        font.setBold(true);
        font.setColor(Font.COLOR_NORMAL);
        font.setFontName("楷体");
        font.setFontHeightInPoints((short)10);
        font.setItalic(true);  /*斜体*/
        font.setUnderline(FontFormatting.U_SINGLE); /*下划线*/
        //创建样式对象
        CellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setFont(font); //将字体样式引入
        cellStyle.setAlignment(HorizontalAlignment.CENTER); //文字居中
        //创建标题行 参数下标
         Row row1 = sheet.createRow(0);
         //合并列
        Cell cell1 = row1.createCell(0);
        //要合并的列 参数：行开始 行结束 列开时 列结束
        CellRangeAddress region = new CellRangeAddress(0,0,0,3);
        sheet.addMergedRegion(region);
        cell1.setCellValue("用户数据");
        //创建类别行 参数下标
        Row row2 = sheet.createRow(1);
        //设置行高 参数：short类型的值
        row2.setHeight((short)250);

        //创建标题行
        Cell cell = null;
        String[] title = {"ID","名字","法名","性别","签名","地址","电话","日期"};
        for(int i = 0;i<title.length;i++){
            cell = row2.createCell(i);
            cell.setCellValue(title[i]);
            //标题行使用样式
            cell.setCellStyle(cellStyle);
        }
        //创建样式对象
        CellStyle cellStyle2 = workbook.createCellStyle();
        //创建日期对象
        DataFormat dataFormat = workbook.createDataFormat();
        //设置日期格式
        cellStyle2.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));
        //创建数据行
        for(int i = 0;i<users.size();i++){
            //遍历一次创建一行
            Row row3 = sheet.createRow(i+2);
            //每行对应放的数据
            row3.createCell(0).setCellValue(users.get(i).getId());
            row3.createCell(1).setCellValue(users.get(i).getName());
            row3.createCell(2).setCellValue(users.get(i).getLegal_name());
            row3.createCell(3).setCellValue(users.get(i).getSex());
            row3.createCell(4).setCellValue(users.get(i).getSign());
            row3.createCell(5).setCellValue(users.get(i).getCity());
            row3.createCell(6).setCellValue(users.get(i).getPhone());

            //设置单元格日期格式
            Cell cell2 = row3.createCell(7);
            cell2.setCellStyle(cellStyle2); //添加日期样式
            cell2.setCellValue(users.get(i).getReg_data()); //添加数据
        }
            //从内存中写入磁盘
            workbook.write(new FileOutputStream(new File("C:\\第三阶段\\TestPoi.xls")));
            //关闭资源
            workbook.close();
    }

    @Test
    public void testInput() throws FileNotFoundException, IOException {
        //通过输入流获取到要读的excel文件
        Workbook workbook = new HSSFWorkbook(new FileInputStream("C:\\第三阶段\\TestPoi.xls"));
        //获取工作表
        Sheet sheet = workbook.getSheet("用户表");
        //声明一个list集合接收User对象
        List<User> users = new ArrayList<>();
        //遍历添加对象到集合
        for(int i = 2;i<sheet.getLastRowNum();i++){
            //获取到当前遍历的行
            Row row = sheet.getRow(i);
            //声明一个对象
            User user = new User();
            //给对象的属性赋值
            user.setId((int)row.getCell(0).getNumericCellValue());
            user.setName(row.getCell(1).getStringCellValue());
            user.setLegal_name(row.getCell(2).getStringCellValue());
            user.setSex(row.getCell(3).getStringCellValue());
            user.setSign(row.getCell(4).getStringCellValue());
            user.setCity(row.getCell(5).getStringCellValue());
            user.setPhone(row.getCell(6).getStringCellValue());
            user.setReg_data(row.getCell(7).getDateCellValue());
            //静对象添加到list集合中
            users.add(user);
        }
        for (User user:users
             ) {
            System.out.println(user);
        }
    }
}
