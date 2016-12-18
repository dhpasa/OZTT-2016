package com.org.oztt.base.util;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import org.krysalis.barcode4j.HumanReadablePlacement;
import org.krysalis.barcode4j.impl.code39.Code39Bean;
import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;
import org.krysalis.barcode4j.tools.UnitConv;


/**
 * @author Administrator
 *
 */
public class DeliveryPicOperation {

        private String inputPicPath;
        private int[] deliveryId_pos1=new int[2];
        private int[] deliveryId_pos2=new int[2];
        private int[] senderName_pos=new int[2];
        private int[] senderPhone_pos=new int[2];
        private int[] senderAddress_pos=new int[2];
        private int[] senderAddress_gap=new int[2];
        private int[] receiverName_pos=new int[2];
        private int[] receiverPhone_pos=new int[2];
        private int[] receiverAddress_pos=new int[2];
        private int[] receiverAddress_gap=new int[2];
        private int[] products_pos=new int[2];
        private int[] weight_pos=new int[2];
        private int[] date_pos=new int[2];
        private int[] barcode_pos=new int[2];
        private double barcodeScaleFactor;
        private double barcodeWideFactor;
        private int senderAddress_maxLineLength;
        private int senderAddress_maxLineLength2;
        private int receiverAddress_maxLineLength;
        private int receiverAddress_maxLineLength2;
        private int products_gap;
        private int mode;

        public DeliveryPicOperation(String configurationPath){
                 try {
             Properties prop = new Properties();
             InputStream inputStream = new FileInputStream(configurationPath);
             prop.load(inputStream);
             String s = DeliveryPicOperation.class.getResource("/").getPath().toString();
             s = java.net.URLDecoder.decode(s, "UTF-8");
             inputPicPath=s + prop.getProperty("inputPicPath").trim();
             date_pos[0]=Integer.parseInt(prop.getProperty("date").split("\\,")[0].trim());
             date_pos[1]=Integer.parseInt(prop.getProperty("date").split("\\,")[1].trim());
             deliveryId_pos1[0]=Integer.parseInt(prop.getProperty("deliveryId1").split("\\,")[0].trim());
             deliveryId_pos1[1]=Integer.parseInt(prop.getProperty("deliveryId1").split("\\,")[1].trim());
             deliveryId_pos2[0]=Integer.parseInt(prop.getProperty("deliveryId2").split("\\,")[0].trim());
             deliveryId_pos2[1]=Integer.parseInt(prop.getProperty("deliveryId2").split("\\,")[1].trim());
             senderName_pos[0]=Integer.parseInt(prop.getProperty("senderName").split("\\,")[0].trim());
             senderName_pos[1]=Integer.parseInt(prop.getProperty("senderName").split("\\,")[1].trim());
             senderPhone_pos[0]=Integer.parseInt(prop.getProperty("senderPhone").split("\\,")[0].trim());
             senderPhone_pos[1]=Integer.parseInt(prop.getProperty("senderPhone").split("\\,")[1].trim());
             senderAddress_pos[0]=Integer.parseInt(prop.getProperty("senderAddress").split("\\,")[0].trim());
             senderAddress_pos[1]=Integer.parseInt(prop.getProperty("senderAddress").split("\\,")[1].trim());
             senderAddress_maxLineLength=Integer.parseInt(prop.getProperty("senderAddress").split("\\,")[2].trim());
             senderAddress_maxLineLength2=Integer.parseInt(prop.getProperty("senderAddress").split("\\,")[3].trim());
             senderAddress_gap[0]=Integer.parseInt(prop.getProperty("senderAddress").split("\\,")[4].trim());
             senderAddress_gap[1]=Integer.parseInt(prop.getProperty("senderAddress").split("\\,")[5].trim());
             receiverName_pos[0]=Integer.parseInt(prop.getProperty("receiverName").split("\\,")[0].trim());
             receiverName_pos[1]=Integer.parseInt(prop.getProperty("receiverName").split("\\,")[1].trim());
             receiverPhone_pos[0]=Integer.parseInt(prop.getProperty("receiverPhone").split("\\,")[0].trim());
             receiverPhone_pos[1]=Integer.parseInt(prop.getProperty("receiverPhone").split("\\,")[1].trim());
             receiverAddress_pos[0]=Integer.parseInt(prop.getProperty("receiverAddress").split("\\,")[0].trim());
             receiverAddress_pos[1]=Integer.parseInt(prop.getProperty("receiverAddress").split("\\,")[1].trim());
             receiverAddress_maxLineLength=Integer.parseInt(prop.getProperty("receiverAddress").split("\\,")[2].trim());
             receiverAddress_maxLineLength2=Integer.parseInt(prop.getProperty("receiverAddress").split("\\,")[3].trim());
             receiverAddress_gap[0]=Integer.parseInt(prop.getProperty("receiverAddress").split("\\,")[4].trim());
             receiverAddress_gap[1]=Integer.parseInt(prop.getProperty("receiverAddress").split("\\,")[5].trim());
             barcode_pos[0]=Integer.parseInt(prop.getProperty("barcode").split("\\,")[0].trim());
             barcode_pos[1]=Integer.parseInt(prop.getProperty("barcode").split("\\,")[1].trim());
             products_pos[0]=Integer.parseInt(prop.getProperty("products").split("\\,")[0].trim());
             products_pos[1]=Integer.parseInt(prop.getProperty("products").split("\\,")[1].trim());
             products_gap=Integer.parseInt(prop.getProperty("products").split("\\,")[2].trim());
             weight_pos[0]=Integer.parseInt(prop.getProperty("weight").split("\\,")[0].trim());
             weight_pos[1]=Integer.parseInt(prop.getProperty("weight").split("\\,")[1].trim());
             barcodeWideFactor=Double.parseDouble(prop.getProperty("barcodeWideFactor").trim());
             barcodeScaleFactor=Double.parseDouble(prop.getProperty("barcodeScaleFactor").trim());
             mode=Integer.parseInt(prop.getProperty("mode").trim());

             //String url = prop.getProperty("url");
            // String user = prop.getProperty("user");
           //  String password = prop.getProperty("password");

         } catch (Exception e) {
                 System.out.println(configurationPath);
             e.printStackTrace();
         }
        }

        public  void createDeliveryPic( String outputPicPath, String deliveryId
                        , String senderName, String senderPhone
                        , String senderAddress, String receiverName, String receiverPhone, String receiverAddress
                        , HashMap<String, Integer> products, String weight, Date sendDate){
                File inputPicFile=new File(inputPicPath);
                String barcodeOutputPath=inputPicFile.getAbsolutePath().substring(0, inputPicFile.getAbsolutePath()
                                .lastIndexOf(File.separator))+"\\barcode_"+deliveryId+".png";
                createBarCode(barcodeOutputPath, deliveryId);
                scaleImage(barcodeOutputPath, barcodeOutputPath, barcodeScaleFactor, false);
                createImageWaterMark(inputPicFile, new File(barcodeOutputPath)
                                , new File(outputPicPath));
                createTextWaterMark( new File(outputPicPath), new File(outputPicPath)
                                , deliveryId, senderName, senderPhone, senderAddress, receiverName, receiverPhone
                                , receiverAddress, products, weight, sendDate);
                //new File(barcodeOutputPath).delete();
        }



         private void createBarCode(String outputImagePath, String barcodeText){
                   try {
               //Create the barcode bean
               Code39Bean bean = new Code39Bean();
               final int dpi = 500;
               //Configure the barcode generator
               bean.setModuleWidth(UnitConv.in2mm(8.0f / dpi)); //makes the narrow bar
               bean.setWideFactor(barcodeWideFactor);
               bean.doQuietZone(false);
               //Open output file
               File outputFile = new File(outputImagePath);
               OutputStream out = new FileOutputStream(outputFile);
               try {
                   //Set up the canvas provider for monochrome JPEG output
                   BitmapCanvasProvider canvas = new BitmapCanvasProvider(
                           out, "image/png", dpi, BufferedImage.TYPE_BYTE_BINARY, false, 0);
                   bean.setMsgPosition(HumanReadablePlacement.HRP_NONE);
                   //Generate the barcode
                   bean.generateBarcode(canvas, barcodeText);
                   //Signal end of generation
                   canvas.finish();
               } finally {
                   out.close();
               }
           } catch (Exception e) {
               e.printStackTrace();
           }

         }

         private void scaleImage(String inputImagePath, String outputImagePath,
                    double scale, boolean flag) {
                try {
                    BufferedImage src = ImageIO.read(new File(inputImagePath)); // 读入文件
                    int width = src.getWidth(); // 得到源图宽
                    int height = src.getHeight(); // 得到源图长
                    if (flag) {// 放大
                        width =(int) (width * scale);
                        height = (int)(height * scale);
                    } else {// 缩小
                        width = (int)(width / scale);
                        height = (int)(height / scale);
                    }
                    Image image = src.getScaledInstance(width, height,
                            Image.SCALE_DEFAULT);
                    BufferedImage tag = new BufferedImage(width, height,
                            BufferedImage.TYPE_INT_RGB);
                    Graphics g = tag.getGraphics();
                    g.drawImage(image, 0, 0, null); // 绘制缩小后的图
                    g.dispose();
                    ImageIO.write(tag, "png", new File(outputImagePath));// 输出到文件流
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

         private void createTextWaterMark(File inputImageFile , File outputImageFile
                        , String deliveryId, String senderName, String senderPhone
                                , String senderAddress, String receiverName, String receiverPhone, String receiverAddress
                                , HashMap<String, Integer> products, String weight, Date sendDate){

                 ArrayList<String> senderAddress_strList=new ArrayList<String>();
                 String tmp=senderAddress;
                 int maxLineLength=senderAddress_maxLineLength;
                 while(tmp.length()>maxLineLength){
                        senderAddress_strList.add(tmp.substring(0,maxLineLength));
                        tmp=tmp.substring(maxLineLength);
                if(senderAddress_strList.size()>=1)
                        maxLineLength=senderAddress_maxLineLength2;
        }
        senderAddress_strList.add(tmp);
        ArrayList<String> receiverAddress_strList=new ArrayList<String>();
        tmp=receiverAddress;
        maxLineLength=receiverAddress_maxLineLength;
        while(tmp.length()>maxLineLength){
                receiverAddress_strList.add(tmp.substring(0,maxLineLength));
                tmp=tmp.substring(maxLineLength);
                if(receiverAddress_strList.size()>=1)
                        maxLineLength=receiverAddress_maxLineLength2;
        }
        receiverAddress_strList.add(tmp);
        BufferedImage image = null;
        if( inputImageFile.equals("") || inputImageFile == null){
            double h = 256/16;
            double w = 85/10;
            int width=(int) 500 , height=500;
            image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        }else{
            try {
                image = ImageIO.read(inputImageFile);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
        Graphics g = image.getGraphics();
        g.setColor(new Color(102,102,102));
        g.setFont(new Font("黑体",Font.BOLD,35));
        // mark date
        SimpleDateFormat ft = new SimpleDateFormat ("dd/MM/yy");
        if(mode==1)
                 g.drawString(ft.format(sendDate).split("/")[2]
                        +"   "+ft.format(sendDate).split("/")[1]
                        +"   "+ft.format(sendDate).split("/")[0]
                                        , date_pos[0], date_pos[1]);
        else
                g.drawString(ft.format(sendDate).split("/")[2]
                        +"/"+ft.format(sendDate).split("/")[1]
                        +"/"+ft.format(sendDate).split("/")[0]
                                        , date_pos[0], date_pos[1]);


        g.setFont(new Font("黑体",Font.BOLD,50));
        // mark sender Name
        g.drawString(senderName, senderName_pos[0], senderName_pos[1]);
        // mark product content
        int count=0;
        for(Map.Entry<String, Integer> product : products.entrySet()){
                g.drawString(product.getKey()+" * "+product.getValue(), products_pos[0]
                                , products_pos[1]+count*products_gap);
                count++;
        }
        // mark sender Phone
        if(mode==1)
                g.drawString(reconstructString(senderPhone), senderPhone_pos[0], senderPhone_pos[1]);
        else
                g.drawString(senderPhone, senderPhone_pos[0], senderPhone_pos[1]);

        // mark receiver Name
        g.drawString(receiverName, receiverName_pos[0], receiverName_pos[1]);


        // mark receiver Phone
        if(mode==1)
                 g.setFont(new Font("黑体",Font.BOLD,50));
        else
                g.setFont(new Font("黑体",Font.BOLD,45));
        g.drawString(reconstructString(receiverPhone), receiverPhone_pos[0],  receiverPhone_pos[1]);

        // mark sender address
        g.setFont(new Font("黑体",Font.BOLD,45));
        count=0;
        for(int i=0;i<senderAddress_strList.size();i++){
                if(i==0)
                        g.drawString(senderAddress_strList.get(i), senderAddress_pos[0]
                                , senderAddress_pos[1]+count*senderAddress_gap[1]);
                else
                        g.drawString(senderAddress_strList.get(i), senderAddress_pos[0]+senderAddress_gap[0]
                                , senderAddress_pos[1]+count*senderAddress_gap[1]);
                count++;
        }
        // mark receiver address
        count=0;
        for(int i=0;i<receiverAddress_strList.size();i++){
                if(i==0)
                        g.drawString(receiverAddress_strList.get(i), receiverAddress_pos[0]
                                , receiverAddress_pos[1]+count*receiverAddress_gap[1]);
                else
                        g.drawString(receiverAddress_strList.get(i), receiverAddress_pos[0]+receiverAddress_gap[0]
                                , receiverAddress_pos[1]+count*receiverAddress_gap[1]);
                count++;
        }
        g.setFont( new Font("黑体",Font.BOLD,55));
        if(!(deliveryId_pos2[0]==0&&deliveryId_pos2[1]==0))
                 g.drawString("* "+deliveryId+" *", deliveryId_pos2[0], deliveryId_pos2[1]);
        g.setFont( new Font("黑体",Font.BOLD,50));
        g.drawString("* "+deliveryId+" *", deliveryId_pos1[0], deliveryId_pos1[1]);

        g.setFont( new Font("黑体",Font.BOLD,45));
        g.drawString(weight, weight_pos[0], weight_pos[1]);

        try {
            ImageIO.write(image, "jpg", outputImageFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
         }


         private void createImageWaterMark(File inputImageFile, File logoImageFile,
                    File outputImageFile) {
                 int x=barcode_pos[0];
                 int y=barcode_pos[1];
                 OutputStream os = null;
                 try{
                         Image srcImg = ImageIO.read(inputImageFile);
                         BufferedImage buffImg = new BufferedImage(srcImg.getWidth(null),
                         srcImg.getHeight(null), BufferedImage.TYPE_INT_RGB);
                         Graphics2D g = buffImg.createGraphics();
                         g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
                      RenderingHints.VALUE_INTERPOLATION_BILINEAR);
                         g.drawImage(srcImg.getScaledInstance(srcImg.getWidth(null),
                                srcImg.getHeight(null), Image.SCALE_SMOOTH), 0, 0, null);
                         ImageIcon logoImgIcon = new ImageIcon(ImageIO.read(logoImageFile));
                         Image logoImg = logoImgIcon.getImage();
                 g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,1));
                 g.drawImage(logoImg, x, y, null);
                 g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER));
                 g.dispose();
                 os = new FileOutputStream(outputImageFile);
                ImageIO.write(buffImg, "jpg", os);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (null != os)
                            os.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                 }
         }

         private String reconstructString(String input){
                 String output="";
                for(int i=0; i<input.length(); i++){
                        output+=input.substring(i,i+1)+" ";
                }
                return output;
         }


}
