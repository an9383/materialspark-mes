package mes.web.io;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.commons.codec.binary.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.em.MeasureInstrmtAdmVo;
import mes.domain.io.MatrlInWhsRqtVo;
import mes.domain.io.ReservationVo;
import mes.domain.mm.ItemPartAdmVo;
import mes.domain.qm.ReliabilityResultVo;
import mes.service.bm.SystemCommonCodeService;



public class CustomerExcelReader {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	//파일을 읽기위해 엑셀파일을 가져온다
	public List<MatrlInWhsRqtVo> fileload(String filename, Logger logger) throws IOException {
		
		
		logger.info("filename = "+ filename);
		int pos = filename.lastIndexOf( "." );
		String ext = filename.substring( pos + 1 );
		FileInputStream fis = null;
		HSSFWorkbook workbook = null;
		XSSFWorkbook workbook2 = null;
		List<MatrlInWhsRqtVo> list = new ArrayList<MatrlInWhsRqtVo>();	
		try {
		
			if(ext.equals("xls")) {
				fis= new FileInputStream(filename);
				workbook= new HSSFWorkbook(fis);			
					
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex=0;
				int columnindex=0;
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				HSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
						
				for(rowindex=1;rowindex<rows;rowindex++){
				    //행을 읽는다
				    HSSFRow row=sheet.getRow(rowindex);
				    String weight = "";
		            String matrlCd = "";
		            String preInWhsQty = "";
				    if(row !=null){
				        //셀의 수
				    	MatrlInWhsRqtVo[] vo = new MatrlInWhsRqtVo[rows];
				    	vo[rowindex-1] = new MatrlInWhsRqtVo();
				        int cells=row.getPhysicalNumberOfCells();
				        for(columnindex=0;columnindex<=13;columnindex++){		        	
				            //셀값을 읽는다
				            HSSFCell cell=row.getCell(columnindex);
				            String value="";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null){
				                continue;
				            }else{
				                //타입별로 내용 읽기
				                switch (cell.getCellType()){
				                case FORMULA:
				                    value=cell.getCellFormula() + "";
				                    break;
				                case NUMERIC:
				                	
									if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}
				                    
				                    break;
				                case STRING:
				                    value=cell.getStringCellValue()+"";
				                    break;
				                case BLANK:
				                    value=cell.getBooleanCellValue()+"";
				                    break;
				                case ERROR:
				                    value=cell.getErrorCellValue()+"";
				                    break;
				                }
				           		              
				           
				            switch(columnindex) {
				            	case 0:
					            	vo[rowindex-1].setSrLot(value);
					            	break;
					            case 1:
					            	vo[rowindex-1].setLotNo(value.replace(",",""));
					            	break;
					            case 2:
					            	vo[rowindex-1].setMatrlCd(value);
					            	matrlCd = value;
					            	break;
					            case 3:
					            	vo[rowindex-1].setMatrlNm(value);
					            	break;
					            case 4:
					            	vo[rowindex-1].setPreInWhsQty(value);
					            	preInWhsQty = value;
					            	break;
					            case 5:
					            	if(!"F".equals(matrlCd.substring(0,1))) {
					            		vo[rowindex-1].setWeightUnit(preInWhsQty);
					            	} else {
					            		vo[rowindex-1].setWeightUnit(value);					            		
						            	weight = value;
					            	}					            	
					            	break;
					            case 6:
					            	if(!"F".equals(matrlCd.substring(0,1))) {
					            		vo[rowindex-1].setRollCnt("1");		
					            	} else {
					            		vo[rowindex-1].setRollCnt(value);		
					            		BigDecimal weightVal = new BigDecimal(weight);
					            		BigDecimal rollCntVal = new BigDecimal(value);
						            	vo[rowindex-1].setPreInWhsQty(weightVal.multiply(rollCntVal).toString());
					            	}					            	
					            	break;	
					            case 7:
					            	vo[rowindex-1].setInWhsLength(value);
					            	break;
					            case 8:
					            	vo[rowindex-1].setSpplyDealCorpCd(value);
					            	break;			            	
					            case 9:
					            	vo[rowindex-1].setSpplyDealCorpNm(value);
					            	break;			         
					            case 10:
					            	vo[rowindex-1].setPreInWhsDate(value);
					            	break;			          
					            case 11:
					            	vo[rowindex-1].setBarcodeNo(value.replace(",",""));
					            	break;
					            case 12:
					            	vo[rowindex-1].setInWhsDesc(value);
					            	break;
					            case 13:
					            	vo[rowindex-1].setPaidGubun(value);
					            	break;
					           
				            }
				          }			           
				            
				        } 			  
				      
					        if(vo[rowindex-1].getLotNo()!=null || "".equals(vo[rowindex-1].getLotNo())) {				        	
					        	list.add(vo[rowindex-1]);	
					        } else {
					        	break;
					        }
				      
				        	      
				   }
				   	    
				}
				
				
				logger.info("list sizezzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz = "+ list);
				
			
			}
			else {
				fis= new FileInputStream(filename);
				workbook2 = new XSSFWorkbook(fis);		
				
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex=0;
				int columnindex=0;
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				XSSFSheet sheet= workbook2.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
						
				for(rowindex=1;rowindex<rows;rowindex++){
					String weight = "";
					String matrlCd = "";
					String preInWhsQty = "";
				    //행을 읽는다
				    XSSFRow row=sheet.getRow(rowindex);
				    if(row !=null){
				        //셀의 수
				    	MatrlInWhsRqtVo[] vo = new MatrlInWhsRqtVo[rows];
				    	vo[rowindex-1] = new MatrlInWhsRqtVo();
				        int cells=row.getPhysicalNumberOfCells();
				        for(columnindex=0;columnindex<=13;columnindex++){		        	
				            //셀값을 읽는다
				            XSSFCell cell=row.getCell(columnindex);
				            String value="";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null){
				                continue;
				            }else{
				                //타입별로 내용 읽기
				                switch (cell.getCellType()){
				                case FORMULA:
				                    value=cell.getCellFormula() + "";
				                    break;
				                case NUMERIC:		
				                	if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
				                case STRING:
				                    value=cell.getStringCellValue()+"";
				                    break;
				                case BLANK:
				                    value=cell.getBooleanCellValue()+"";
				                    break;
				                case ERROR:
				                    value=cell.getErrorCellValue()+"";
				                    break;
				                }
				            
				                
					            
					            switch(columnindex) {
					            	case 0:
						            	vo[rowindex-1].setSrLot(value);
						            	break;
						            case 1:
						            	vo[rowindex-1].setLotNo(value.replace(",",""));
						            	break;
						            case 2:
						            	vo[rowindex-1].setMatrlCd(value);
						            	matrlCd = value;
						            	break;
						            case 3:
						            	vo[rowindex-1].setMatrlNm(value);
						            	break;
						            case 4:
						            	vo[rowindex-1].setPreInWhsQty(value);
						            	preInWhsQty = value;
						            	break;
						            case 5:
						            	if(!"F".equals(matrlCd.substring(0,1))) {
						            		vo[rowindex-1].setWeightUnit(preInWhsQty);
						            	} else {
						            		vo[rowindex-1].setWeightUnit(value);					            		
							            	weight = value;
						            	}					            	
						            	break;
						            case 6:
						            	if(!"F".equals(matrlCd.substring(0,1))) {
						            		vo[rowindex-1].setRollCnt("1");		
						            	} else {
						            		vo[rowindex-1].setRollCnt(value);		
						            		BigDecimal weightVal = new BigDecimal(weight);
						            		BigDecimal rollCntVal = new BigDecimal(value);
							            	vo[rowindex-1].setPreInWhsQty(weightVal.multiply(rollCntVal).toString());
						            	}					            	
						            	break;	
						            case 7:
						            	vo[rowindex-1].setInWhsLength(value);
						            	break;
						            case 8:
						            	vo[rowindex-1].setSpplyDealCorpCd(value);
						            	break;			            	
						            case 9:
						            	vo[rowindex-1].setSpplyDealCorpNm(value);
						            	break;			         
						            case 10:
						            	vo[rowindex-1].setPreInWhsDate(value);
						            	break;			          
						            case 11:
						            	vo[rowindex-1].setBarcodeNo(value.replace(",",""));
						            	break;
						            case 12:
						            	vo[rowindex-1].setInWhsDesc(value);
						            	break;
						            case 13:
						            	vo[rowindex-1].setPaidGubun(value);
						            	break;
						           
					            }
				          }
				           
				            
				        } 
				        if(vo[rowindex-1].getLotNo()!=null || "".equals(vo[rowindex-1].getLotNo())) {				        	
				        	list.add(vo[rowindex-1]);	
				        } else {
				        	break;
				        }
				   }
				   	    
				}
				
				
				logger.info("list size = "+ list.size());
				
			
			}
		} catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            
        } finally {
            try {
                // 사용한 자원은 finally에서 해제
                if( workbook!= null) { workbook.close();}
                if( workbook2!= null) { workbook2.close();}
                if( fis!= null) {fis.close();}
                
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		return list;
	}
	
	
	// 계측기관리 엑셀 업로드
		public List<MeasureInstrmtAdmVo> measureFileload(String filename, Logger logger) throws IOException {
			logger.info("filename = " + filename);
			int pos = filename.lastIndexOf(".");
			String ext = filename.substring(pos + 1);
			FileInputStream fis = null;
			HSSFWorkbook workbook = null;
			XSSFWorkbook workbook2 = null;
			List<MeasureInstrmtAdmVo> list = new ArrayList<MeasureInstrmtAdmVo>();
			try {
				if (ext.equals("xls")) {
					fis = new FileInputStream(filename);
					workbook = new HSSFWorkbook(fis);

					DecimalFormat df = new DecimalFormat();

					int rowindex = 0;
					int columnindex = 0;
					// 시트 수 (첫번째에만 존재하므로 0을 준다)
					// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
					HSSFSheet sheet = workbook.getSheetAt(0);
					// 행의 수
					int rows = sheet.getPhysicalNumberOfRows();

					for (rowindex = 1; rowindex < rows; rowindex++) {
						// 행을 읽는다
						HSSFRow row = sheet.getRow(rowindex);
						Row row2 = row;

						if (row != null && !row2.getZeroHeight()) {

							// 셀의 수
							MeasureInstrmtAdmVo[] vo = new MeasureInstrmtAdmVo[rows];
							vo[rowindex - 1] = new MeasureInstrmtAdmVo();
							int cells = row.getPhysicalNumberOfCells();
							for (columnindex = 0; columnindex <= 14; columnindex++) {
								// 셀값을 읽는다
								HSSFCell cell = row.getCell(columnindex);
								String value = "";
								// 셀이 빈값일경우를 위한 널체크
								if (cell == null) {
									continue;
								} else {
									// 타입별로 내용 읽기
									switch (cell.getCellType()) {
									case FORMULA:
										value = cell.getCellFormula() + "";
										break;
									case NUMERIC:

										if (DateUtil.isCellDateFormatted(cell)) {
											SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
											value = formatter.format(cell.getDateCellValue()) + "";
										} else {
											double ddata = cell.getNumericCellValue();
											value = df.format(ddata) + "";
										}

										break;
									case STRING:
										value = cell.getStringCellValue() + "";
										break;
									case BLANK:
										value = cell.getStringCellValue() + "";
										break;
									case ERROR:
										value = cell.getErrorCellValue() + "";
										break;
									}

									switch (columnindex) {
									case 0:
										try {
											vo[rowindex - 1].setAdmNo(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setAdmNo("");
										}
										break;
									case 1:
										try {
											vo[rowindex - 1].setMitNo(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitNo("");
										}
										break;
									case 2:
										try {
											vo[rowindex - 1].setMitNm(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitNm("");
										}
										break;
									case 3:
										try {
											vo[rowindex - 1].setMitLoc(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitLoc("");
										}
										break;
									case 4:
										try {
											vo[rowindex - 1].setAdmDept(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setAdmDept("");
										}
										break;
									case 5:
										try {
											vo[rowindex - 1].setMainChargr(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMainChargr("");
										}
										break;
									case 6:
										try {
											vo[rowindex - 1].setCorrCycle(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setCorrCycle("");
										}
										break;
									case 7:
										try {
											vo[rowindex - 1].setCorrCount(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setCorrCount("");
										}
										break;
									case 8:
										try {
											vo[rowindex - 1].setMitForm(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitForm("");
										}
										break;
									case 9:
										try {
											vo[rowindex - 1].setMitKind(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitKind("");
										}
										break;
									case 10:
										try {
											vo[rowindex - 1].setModelNm(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setModelNm("");
										}
										break;
									case 11:
										try {
											vo[rowindex - 1].setMfcCorpNm(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMfcCorpNm("");
										}
										break;
									case 12:
										try {
											vo[rowindex - 1].setAcqDate(value.replaceAll("-", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setAcqDate("");
										}
										break;
									case 13:
										try {
											vo[rowindex - 1].setAcqCost(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setAcqCost("0");
										}
										break;
									case 14:
										try {
											vo[rowindex - 1].setMitDesc(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitDesc("");
										}
										break;
									}
								}
							}
							if (!"".equals(vo[rowindex - 1].getAdmNo()) || !"".equals(vo[rowindex - 1].getMitNm())) {
								list.add(vo[rowindex - 1]);
							}
						}
					}

					logger.info("list size = " + list.size());

					return list;
				} else {
					logger.info(filename);

					fis = new FileInputStream(filename);
					workbook2 = new XSSFWorkbook(fis);
					DecimalFormat df = new DecimalFormat();

					int rowindex = 0;
					int columnindex = 0;
					// 시트 수 (첫번째에만 존재하므로 0을 준다)
					// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
					XSSFSheet sheet = workbook2.getSheetAt(0);
					// 행의 수
					int rows = sheet.getPhysicalNumberOfRows();

					for (rowindex = 1; rowindex < rows; rowindex++) {
						// 행을 읽는다
						XSSFRow row = sheet.getRow(rowindex);
						Row row2 = row;

						if (row != null && !row2.getZeroHeight()) {

							/*
							 * // 셀데이터 확인 로직 추가 21-02-25 //셀 데이터 확인 boolean checkCell = false; //셀 데이터 전체가
							 * 공백일경우 체크 for(columnindex=0;columnindex<=14;columnindex++){ XSSFCell
							 * cell=row.getCell(columnindex); //셀 데이터 전체가 공백일경우 체크
							 * System.out.println(rowindex); switch (cell.getCellType()){ //공백일경우 다음셀 확인
							 * case BLANK: break; //공백이 아닐경우 체크로직 중단 default: checkCell=true; break; } //공백이
							 * 아닌셀이 발견될경우 체크로직 중단 if(checkCell) { break; } } //전체 공백인경우 메인 row 루프 중단
							 * if(!checkCell) { break; } // 셀데이터 확인 로직 추가 21-02-25
							 */
							// 셀의 수
							MeasureInstrmtAdmVo[] vo = new MeasureInstrmtAdmVo[rows];
							vo[rowindex - 1] = new MeasureInstrmtAdmVo();
							int cells = row.getPhysicalNumberOfCells();
							for (columnindex = 0; columnindex <= 14; columnindex++) {
								// 셀값을 읽는다
								XSSFCell cell = row.getCell(columnindex);

								String value = "";
								// 셀이 빈값일경우를 위한 널체크
								if (cell == null) {
									continue;
								} else {
									logger.info("" + cell.getCellType());

									// 타입별로 내용 읽기
									switch (cell.getCellType()) {
									case FORMULA:
										value = cell.getCellFormula() + "";
										break;
									case NUMERIC:
										if (DateUtil.isCellDateFormatted(cell)) {
											SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
											value = formatter.format(cell.getDateCellValue()) + "";
										} else {
											double ddata = cell.getNumericCellValue();
											value = df.format(ddata) + "";
										}

										break;
									case STRING:
										value = cell.getStringCellValue() + "";
										break;
									case BLANK:
										value = cell.getStringCellValue() + "";
										break;
									case ERROR:
										value = cell.getErrorCellValue() + "";
										break;
									}
									switch (columnindex) {
									case 0:
										try {
											vo[rowindex - 1].setAdmNo(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setAdmNo("");
										}
										break;
									case 1:
										try {
											vo[rowindex - 1].setMitNo(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitNo("");
										}
										break;
									case 2:
										try {
											vo[rowindex - 1].setMitNm(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitNm("");
										}
										break;
									case 3:
										try {
											vo[rowindex - 1].setMitLoc(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitLoc("");
										}
										break;
									case 4:
										try {
											vo[rowindex - 1].setAdmDept(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setAdmDept("");
										}
										break;
									case 5:
										try {
											vo[rowindex - 1].setMainChargr(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMainChargr("");
										}
										break;
									case 6:
										try {
											vo[rowindex - 1].setCorrCycle(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setCorrCycle("");
										}
										break;
									case 7:
										try {
											vo[rowindex - 1].setCorrCount(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setCorrCount("");
										}
										break;
									case 8:
										try {
											vo[rowindex - 1].setMitForm(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitForm("");
										}
										break;
									case 9:
										try {
											vo[rowindex - 1].setMitKind(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitKind("");
										}
										break;
									case 10:
										try {
											vo[rowindex - 1].setModelNm(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setModelNm("");
										}
										break;
									case 11:
										try {
											vo[rowindex - 1].setMfcCorpNm(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMfcCorpNm("");
										}
										break;
									case 12:
										try {
											vo[rowindex - 1].setAcqDate(value.replaceAll("-", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setAcqDate("");
										}
										break;
									case 13:
										try {
											vo[rowindex - 1].setAcqCost(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setAcqCost("0");
										}
										break;
									case 14:
										try {
											vo[rowindex - 1].setMitDesc(value.replaceAll(",", ""));
										} catch (NumberFormatException e) {
											vo[rowindex - 1].setMitDesc("");
										}
										break;
									}
								}
							}
							if (!"".equals(vo[rowindex - 1].getAdmNo()) || !"".equals(vo[rowindex - 1].getMitNm())) {
								list.add(vo[rowindex - 1]);
							}
						}
					}
					logger.info("list size = " + list.size());
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			} finally {
				try {
					// 사용한 자원은 finally에서 해제
					if (workbook != null) {
						workbook.close();
					}
					if (workbook2 != null) {
						workbook2.close();
					}
					if (fis != null) {
						fis.close();
					}

				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			logger.info("엑셀 list" + list);
			return list;
		}
	
	
	//3공장 업로드(iosc0010_가입고)
	public List<MatrlInWhsRqtVo> fileload_F3(String filename, Logger logger) throws IOException {
		logger.info("filename = "+ filename);
		int pos					= filename.lastIndexOf( "." );
		String ext				= filename.substring( pos + 1 );
		FileInputStream fis		= null; 
		HSSFWorkbook workbook	= null;
		XSSFWorkbook workbook2	= null;
		List<MatrlInWhsRqtVo> list = new ArrayList<MatrlInWhsRqtVo>();	
		try {
			if(ext.equals("xls")) {
				fis			= new FileInputStream(filename);
				workbook	= new HSSFWorkbook(fis);			
					
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex=0;
				int columnindex=0;
				
				boolean cellCheck = false;
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				HSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
						
				for(rowindex=1;rowindex<rows;rowindex++){
					cellCheck = false;
					//행을 읽는다
				    HSSFRow row=sheet.getRow(rowindex);
				    if(row !=null){
				    	//셀의 수
				    	MatrlInWhsRqtVo[] vo 	= new MatrlInWhsRqtVo[rows];
				    	vo[rowindex-1] 			= new MatrlInWhsRqtVo();
				        int cells				= row.getPhysicalNumberOfCells();
				        
				        loop:
				        for(columnindex=0;columnindex<=11;columnindex++){		        	
				            //셀값을 읽는다
				            HSSFCell cell	= row.getCell(columnindex);
				            String value	= "";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
				                continue;
				            }else{
				            	//타입별로 내용 읽기
				                switch (cell.getCellType()){
					                case FORMULA:
					                	value=cell.getCellFormula() + "";
					                break;
					                
					                case NUMERIC:
									if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}
				                    break;
				                    
					                case STRING:
					                	value=cell.getStringCellValue()+"";
					                break;
					                
					                case BLANK:
					                	value=cell.getBooleanCellValue()+"";
					                break;
					                
					                case ERROR:
					                	value=cell.getErrorCellValue()+"";
					                break;
				                }
				                switch(columnindex) {
					            	case 0:
						            	vo[rowindex-1].setPreInWhsDate(value);
						            	cellCheck = true;
						            break;
						            case 1:
						            	vo[rowindex-1].setLifeTime(value);
						            	cellCheck = true;
						            break;
						            case 2:
						            	vo[rowindex-1].setSurfaceDate(value);
						            	cellCheck = true;
						            break;
						            case 3:
						            	vo[rowindex-1].setData1(value);
						            	cellCheck = true;
						            break;
						            case 4:
						            	vo[rowindex-1].setData2(value);
						            	cellCheck = true;
						            break;
						            case 5:
						            	vo[rowindex-1].setInWhsDesc(value);
						            	cellCheck = true;
						            break;
						            case 6:
						            	vo[rowindex-1].setMatrlCd(value);
						            	cellCheck = true;
						            break;			            	
						            case 7:
						            	vo[rowindex-1].setMotherRollLot(value);
						            	cellCheck = true;
						            break;			         
						            case 8:
						            	vo[rowindex-1].setMotherRollLotNo(value);
						            	cellCheck = true;
						            break;			          
						            case 9:
						            	vo[rowindex-1].setStandard(value);
						            	cellCheck = true;
						            break;
						            case 10:
						            	vo[rowindex-1].setRollCount(value);
						            	cellCheck = true;
						            break;
						            case 11:
						            	if(value.replaceAll("\\s", "").replaceAll(",", "").matches("^[0-9]*$") || value.replaceAll("\\s", "").replaceAll(",", "").matches("^[0-9]*+\\.(\\d{1}|\\d{2})$") || value.replaceAll("\\s", "").equals("")) {
						            		vo[rowindex-1].setPreInWhsQty(value.replaceAll("\\s", ""));
							            	cellCheck = true;
						            	}else {
						            		list = new ArrayList<MatrlInWhsRqtVo>();
						            		break loop;
						            	}
						            break;
				                }
				            }
				        }
				        if(cellCheck) {
				        	list.add(vo[rowindex-1]);
				        }else {
				        	break;
				        }
				    }
				}
				logger.info("list size = "+ list.size());
			}else {
				fis					= new FileInputStream(filename);
				workbook2 			= new XSSFWorkbook(fis);
				DecimalFormat df	= new DecimalFormat();
				 
				int rowindex	= 0;
				int columnindex	= 0;
				
				boolean cellCheck = false;
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				XSSFSheet sheet= workbook2.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
				
				loop:
				for(rowindex=1;rowindex<rows;rowindex++){
					cellCheck = false;
				    //행을 읽는다
				    XSSFRow row = sheet.getRow(rowindex);
				    if(row !=null){
				        //셀의 수
				    	MatrlInWhsRqtVo[] vo 	= new MatrlInWhsRqtVo[rows];
				    	vo[rowindex-1] 			= new MatrlInWhsRqtVo();
				        int cells				= row.getPhysicalNumberOfCells(); 
				        
				        for(columnindex=0;columnindex<=11;columnindex++){		        	
				            //셀값을 읽는다
				            XSSFCell cell	= row.getCell(columnindex);
				            String value	= "";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
				            	continue;
				            }else {
				            	//타입별로 내용 읽기
				                switch (cell.getCellType()){
					                case FORMULA:
					                    value=cell.getCellFormula() + "";
				                    break;
					                case NUMERIC:
				                	if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
					                case STRING:
					                	value=cell.getStringCellValue()+"";
				                    break;
					                case BLANK:
					                	value=cell.getBooleanCellValue()+"";
				                    break;
					                case ERROR:
					                	value=cell.getErrorCellValue()+"";
				                    break;
				                }
					            switch(columnindex) {
					            	case 0:
						            	vo[rowindex-1].setPreInWhsDate(value);
						            	cellCheck = true;
						            break;
						            case 1:
						            	vo[rowindex-1].setLifeTime(value);
						            	cellCheck = true;
						            break;
						            case 2:
						            	vo[rowindex-1].setSurfaceDate(value);
						            	cellCheck = true;
						            break;
						            case 3:
						            	vo[rowindex-1].setData1(value);
						            	cellCheck = true;
						            break;
						            case 4:
						            	vo[rowindex-1].setData2(value);
						            	cellCheck = true;
						            break;
						            case 5:
						            	vo[rowindex-1].setInWhsDesc(value);
						            	cellCheck = true;
						            break;
						            case 6:
						            	vo[rowindex-1].setMatrlCd(value);
						            	cellCheck = true;
						            break;			            	
						            case 7:
						            	vo[rowindex-1].setMotherRollLot(value);
						            	cellCheck = true;
						            break;			         
						            case 8:
						            	vo[rowindex-1].setMotherRollLotNo(value);
						            	cellCheck = true;
						            break;			          
						            case 9:
						            	vo[rowindex-1].setStandard(value);
						            	cellCheck = true;
						            break;
						            case 10:
						            	vo[rowindex-1].setRollCount(value);
						            	cellCheck = true;
						            break;
						            case 11:
						            	if(value.replaceAll("\\s", "").replaceAll(",", "").matches("^[0-9]*$") || value.replaceAll("\\s", "").replaceAll(",", "").matches("^[0-9]*+\\.(\\d{1}|\\d{2})$") || value.replaceAll("\\s", "").equals("")) {
						            		vo[rowindex-1].setPreInWhsQty(value.replaceAll("\\s", ""));
							            	cellCheck = true;
						            	}else {
						            		list = new ArrayList<MatrlInWhsRqtVo>();
						            		break loop;
						            	}
						            break;
					            }
				            }
				        }
				        if(cellCheck) {
				        	list.add(vo[rowindex-1]);
				        }else {
				        	break;
				        }
				    }
				}
				logger.info("list size = "+ list.size());
			}
		} catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                // 사용한 자원은 finally에서 해제
                if( workbook!= null) { workbook.close();}
                if( workbook2!= null) { workbook2.close();}
                if( fis!= null) {fis.close();}
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		return list;
	}
	
	//3공장 업로드(qmsc3210 신뢰성 검사결과)
	public List<ReliabilityResultVo> fileload_qmsc3210_F3(String filename, Logger logger, List<SystemCommonCodeVo> shillingValList) throws IOException {
		logger.info("filename = "+ filename);
		int pos					= filename.lastIndexOf( "." );
		String ext				= filename.substring( pos + 1 );
		FileInputStream fis		= null; 
		HSSFWorkbook workbook	= null;
		XSSFWorkbook workbook2	= null;
		List<ReliabilityResultVo> list = new ArrayList<ReliabilityResultVo>();
		SystemCommonCodeVo filterVo = new SystemCommonCodeVo();
		try {
			if(ext.equals("xls")) {
				fis			= new FileInputStream(filename);
				workbook	= new HSSFWorkbook(fis);			
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex	= 0;
				int columnindex	= 0;
				
				boolean cellCheck = false;

				String shillingGubun = "";
				//실링구분 -> 001 = 48시간 , 002 = 24시간 , 003 = 15시간
				//시트 수 (1,2,3번째에만 존재하므로 0,1,2을 준다)
				for(int i = 0 ; i < 3 ; i++) {
					HSSFSheet sheet= workbook.getSheetAt(i);
					if( i == 0 ) {
						shillingGubun = "002";
						/*filterVo = shillingValList.stream()
								.filter(v -> v.getBaseCd().equals("002"))
								.collect(Collectors.toList());*/
					} else if( i == 1) {
						shillingGubun = "001";
						/*filterVo = shillingValList.stream()
								.filter(v -> v.getBaseCd().equals("001"))
								.collect(Collectors.toList());*/
					} else if( i == 2) {
						shillingGubun = "003";
						/*filterVo = shillingValList.stream()
								.filter(v -> v.getBaseCd().equals("003"))
								.collect(Collectors.toList());*/
					}					
					for( int j = 0; j < shillingValList.size() ; j ++) {
						if(shillingValList.get(j).getBaseCd().equals(shillingGubun)) {
							filterVo = shillingValList.get(j);
						}
					}
					
					//행의 수
					int rows=sheet.getPhysicalNumberOfRows();
					
					loop:
					for(rowindex=6;rowindex<=rows;rowindex++){
						cellCheck = false;
					    //행을 읽는다
						HSSFRow row = sheet.getRow(rowindex);
					    if(row !=null){
					        //셀의 수
					    	ReliabilityResultVo[] vo 	= new ReliabilityResultVo[rows];
					    	vo[rowindex-6] 			= new ReliabilityResultVo();
					    	
					    	vo[rowindex-6].setShillingGubun(shillingGubun);
					        int cells				= row.getPhysicalNumberOfCells(); 
					        
					        for(columnindex=2;columnindex<=16;columnindex++){		        	
					            //셀값을 읽는다
					        	HSSFCell cell	= row.getCell(columnindex);
					            String value	= "";
					            
					            //셀이 빈값일경우를 위한 널체크
					            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
					            	continue;
					            }else {
					            	//타입별로 내용 읽기
					                switch (cell.getCellType()){
						                case FORMULA:
						                    value=cell.getCellFormula() + "";
					                    break;
						                case NUMERIC:
					                	if(DateUtil.isCellDateFormatted(cell)) {
					                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					                		value = formatter.format(cell.getDateCellValue()) + "";
					                	} else {
					                		double ddata = cell.getNumericCellValue();
					                		value = df.format(ddata) + "";
					                	}            
					                			                	
					                    break;
						                case STRING:
						                	value=cell.getStringCellValue()+"";
					                    break;
						                case BLANK:
						                	value=cell.getBooleanCellValue()+"";
					                    break;
						                case ERROR:
						                	value=cell.getErrorCellValue()+"";
					                    break;
					                }
						            switch(columnindex-2) {
						            	case 0:
							            	vo[rowindex-6].setTeamCd(value);
							            	cellCheck = true;
							            break;
							            case 1:
							            	vo[rowindex-6].setProductDate(value);
							            	cellCheck = true;
							            break;
							            case 2:
							            	vo[rowindex-6].setTestDate(value);
							            	cellCheck = true;
							            break;
							            case 3:
							            	vo[rowindex-6].setWorkerNm(value);
							            	cellCheck = true;
							            break;
							            case 4:
							            	vo[rowindex-6].setGijongNm(value);
							            	cellCheck = true;
							            break;
							            case 5:
							            	vo[rowindex-6].setQutyNm(value);
							            	cellCheck = true;
							            break;
							            case 6:
							            	vo[rowindex-6].setEquipNm(value);
							            	cellCheck = true;
							            break;			            	
							            case 7:
							            	vo[rowindex-6].setChangeM(value);
							            	cellCheck = true;
							            break;			         
							            case 8:
							            	vo[rowindex-6].setMetalLotNo(value);
							            	cellCheck = true;
							            break;			          
							            case 9:
							            	if(value.contains("파단")) {
							            		vo[rowindex-6].setBottomResult("OK");
							            	} else {
							            		value = value.replaceAll("[^0-9.]", "");
							            		if( !value.isEmpty() ) {
								            		if(Float.parseFloat(value) >= Float.parseFloat(filterVo.getBaseCdAbbr()) ) {
								            			vo[rowindex-6].setBottomResult("OK");
								            		} else {
								            			vo[rowindex-6].setBottomResult("NG");
								            		}
							            		}
							            	}
							            	vo[rowindex-6].setBottomVal(value);
							            	cellCheck = true;
							            break;
							            case 10:
							            	if(value.contains("파단")) {
							            		vo[rowindex-6].setTopResult("OK");
							            	} else {
							            		value = value.replaceAll("[^0-9.]", "");
							            		if( !value.isEmpty() ) {
								            		if(Float.parseFloat(value) >= Float.parseFloat(filterVo.getBaseCdAbbr()) ) {
									            		vo[rowindex-6].setTopResult("OK");
								            		} else {
								            			vo[rowindex-6].setTopResult("NG");
								            		}
							            		}
							            	}
							            	vo[rowindex-6].setTopVal(value);
							            	cellCheck = true;
							            break;
							            case 11:
							            	vo[rowindex-6].setSideLeft(value);
							            	cellCheck = true;
							            break;
							            case 12:
							            	vo[rowindex-6].setSideRight(value);
							            	cellCheck = true;
							            break;
							            case 13:
							            	vo[rowindex-6].setAfterBottom(value);
							            	cellCheck = true;
							            break;
							            case 14:
							            	vo[rowindex-6].setAfterTop(value);
							            	cellCheck = true;
							            break;
							            /*case 11:
							            	if(value.replaceAll("\\s", "").replaceAll(",", "").matches("^[0-9]*$") || value.replaceAll("\\s", "").replaceAll(",", "").matches("^[0-9]*+\\.(\\d{1}|\\d{2})$") || value.replaceAll("\\s", "").equals("")) {
							            		vo[rowindex-7].setPreInWhsQty(value.replaceAll("\\s", ""));
								            	cellCheck = true;
							            	}else {
							            		list = new ArrayList<MatrlInWhsRqtVo>();
							            		break loop;
							            	}
							            break;*/
						            }
					            }
					        }
					        if(cellCheck) {
					        	list.add(vo[rowindex-6]);
					        }else {
					        	break;
					        }
					    }
					}
				}
				logger.info("list size = "+ list.size());
			} else {
			
				fis					= new FileInputStream(filename);
				workbook2 			= new XSSFWorkbook(fis);
				DecimalFormat df	= new DecimalFormat();
				 
				int rowindex	= 0;
				int columnindex	= 0;
				
				boolean cellCheck = false;
				
				String shillingGubun = "";
				//실링구분 -> 001 = 48시간 , 002 = 24시간 , 003 = 15시간
				//시트 1에는 일일실링(24시간) 시트2에는 2일실링(48시간) 시트3에는 15시간이 존재
				//시트 수 (1,2,3번째에만 존재하므로 0,1,2을 준다)
				for(int i = 0 ; i < 3 ; i++) {
					XSSFSheet sheet= workbook2.getSheetAt(i);
					//행의 수
					int rows=sheet.getPhysicalNumberOfRows();
					if( i == 0 ) {
						shillingGubun = "002";
						/*filterVo = shillingValList.stream()
								.filter(v -> v.getBaseCd().equals("002"))
								.collect(Collectors.toList());*/
					} else if( i == 1) {
						shillingGubun = "001";
						/*filterVo = shillingValList.stream()
								.filter(v -> v.getBaseCd().equals("001"))
								.collect(Collectors.toList());*/
					} else if( i == 2) {
						shillingGubun = "003";
						/*filterVo = shillingValList.stream()
								.filter(v -> v.getBaseCd().equals("003"))
								.collect(Collectors.toList());*/
					}	
					for( int j = 0; j < shillingValList.size() ; j ++) {
						if(shillingValList.get(j).getBaseCd().equals(shillingGubun)) {
							filterVo = shillingValList.get(j);
						}
					}
					loop:
					for(rowindex=6;rowindex<=rows;rowindex++){
						cellCheck = false;
					    //행을 읽는다
					    XSSFRow row = sheet.getRow(rowindex);
					    if(row !=null){
					        //셀의 수
					    	ReliabilityResultVo[] vo 	= new ReliabilityResultVo[rows];
					    	vo[rowindex-6] 			= new ReliabilityResultVo();
					    	
					    	vo[rowindex-6].setShillingGubun(shillingGubun);
					        int cells				= row.getPhysicalNumberOfCells(); 
					        
					        for(columnindex=2;columnindex<=16;columnindex++){		        	
					            //셀값을 읽는다
					            XSSFCell cell	= row.getCell(columnindex);
					            String value	= "";
					            
					            //셀이 빈값일경우를 위한 널체크
					            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){					            
					            	continue;
					            }else {
					            	//타입별로 내용 읽기
					                switch (cell.getCellType()){
						                case FORMULA:
						                    value=cell.getCellFormula() + "";
					                    break;
						                case NUMERIC:
					                	if(DateUtil.isCellDateFormatted(cell)) {
					                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					                		value = formatter.format(cell.getDateCellValue()) + "";
					                	} else {
					                		double ddata = cell.getNumericCellValue();
					                		value = df.format(ddata) + "";
					                	}            
					                			                	
					                    break;
						                case STRING:
						                	value=cell.getStringCellValue()+"";
					                    break;
						                case BLANK:
						                	value=cell.getBooleanCellValue()+"";
					                    break;
						                case ERROR:
						                	value=cell.getErrorCellValue()+"";
					                    break;
					                }
						            switch(columnindex-2) {
						            	case 0:
							            	vo[rowindex-6].setTeamCd(value);
							            	cellCheck = true;
							            break;
							            case 1:
							            	vo[rowindex-6].setProductDate(value);
							            	cellCheck = true;
							            break;
							            case 2:
							            	vo[rowindex-6].setTestDate(value);
							            	cellCheck = true;
							            break;
							            case 3:
							            	vo[rowindex-6].setWorkerNm(value);
							            	cellCheck = true;
							            break;
							            case 4:
							            	vo[rowindex-6].setGijongNm(value);
							            	cellCheck = true;
							            break;
							            case 5:
							            	vo[rowindex-6].setQutyNm(value);
							            	cellCheck = true;
							            break;
							            case 6:
							            	vo[rowindex-6].setEquipNm(value);
							            	cellCheck = true;
							            break;			            	
							            case 7:
							            	vo[rowindex-6].setChangeM(value);
							            	cellCheck = true;
							            break;			         
							            case 8:
							            	vo[rowindex-6].setMetalLotNo(value);
							            	cellCheck = true;
							            break;			          
							            case 9:
							            	if(value.contains("파단")) {
							            		vo[rowindex-6].setBottomResult("OK");
							            	} else {
							            		value = value.replaceAll("[^0-9.]", "");
							            		if( !value.isEmpty() ) {
								            		if(Float.parseFloat(value) >= Float.parseFloat(filterVo.getBaseCdAbbr()) ) {
								            			vo[rowindex-6].setBottomResult("OK");
								            		} else {
								            			vo[rowindex-6].setBottomResult("NG");
								            		}
							            		}
							            	}
							            	vo[rowindex-6].setBottomVal(value);
							            	cellCheck = true;
							            break;
							            case 10:
							            	if(value.contains("파단")) {
							            		vo[rowindex-6].setTopResult("OK");
							            	} else {
							            		value = value.replaceAll("[^0-9.]", "");
							            		if( !value.isEmpty() ) {
								            		if(Float.parseFloat(value) >= Float.parseFloat(filterVo.getBaseCdAbbr()) ) {
									            		vo[rowindex-6].setTopResult("OK");
								            		} else {
								            			vo[rowindex-6].setTopResult("NG");
								            		}
							            		}
							            	}
							            	vo[rowindex-6].setTopVal(value);
							            	cellCheck = true;
							            break;
							            case 11:
							            	vo[rowindex-6].setSideLeft(value);
							            	cellCheck = true;
							            break;
							            case 12:
							            	vo[rowindex-6].setSideRight(value);
							            	cellCheck = true;
							            break;
							            case 13:
							            	vo[rowindex-6].setAfterBottom(value);
							            	cellCheck = true;
							            break;
							            case 14:
							            	vo[rowindex-6].setAfterTop(value);
							            	cellCheck = true;
							            break;
							            /*case 11:
							            	if(value.replaceAll("\\s", "").replaceAll(",", "").matches("^[0-9]*$") || value.replaceAll("\\s", "").replaceAll(",", "").matches("^[0-9]*+\\.(\\d{1}|\\d{2})$") || value.replaceAll("\\s", "").equals("")) {
							            		vo[rowindex-7].setPreInWhsQty(value.replaceAll("\\s", ""));
								            	cellCheck = true;
							            	}else {
							            		list = new ArrayList<MatrlInWhsRqtVo>();
							            		break loop;
							            	}
							            break;*/
						            }
					            }
					        }
					        if(cellCheck) {
					        	list.add(vo[rowindex-6]);
					        }else {
					        	break;
					        }
					    }
					}
				}
				logger.info("list size = "+ list.size());
			}
		} catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
			list = new ArrayList<ReliabilityResultVo>();
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
        	list = new ArrayList<ReliabilityResultVo>();
            e.printStackTrace();
        } catch (Exception e) {
			// TODO Auto-generated catch block
        	list = new ArrayList<ReliabilityResultVo>();
			e.printStackTrace();
		} finally {
            try {
                // 사용한 자원은 finally에서 해제
                if( workbook!= null) { workbook.close();}
                if( workbook2!= null) { workbook2.close();}
                if( fis!= null) {fis.close();}
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		return list;
	}
	
	
	//품목정보(일반자재) 엑셀 업로드
	public List<ItemPartAdmVo> itemPartFileload(String filename, Logger logger) throws IOException {
		logger.info("filename = "+ filename);
		int pos = filename.lastIndexOf( "." );
		String ext = filename.substring( pos + 1 );
		FileInputStream fis = null;
		HSSFWorkbook workbook = null;
		XSSFWorkbook workbook2 = null;
		List<ItemPartAdmVo> list = new ArrayList<ItemPartAdmVo>();	
		try {
			if(ext.equals("xls")) {
				fis= new FileInputStream(filename);
				workbook= new HSSFWorkbook(fis);		
				
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex=0;
				int columnindex=0;
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				HSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
						
				for(rowindex=1;rowindex<rows;rowindex++){
				    //행을 읽는다
				    HSSFRow row=sheet.getRow(rowindex);
				    Row row2 = row;
					  
				    if(row !=null && !row2.getZeroHeight()){
				    	
				    	
				        //셀의 수
				    	ItemPartAdmVo[] vo = new ItemPartAdmVo[rows];
				    	vo[rowindex-1] = new ItemPartAdmVo();
				        int cells=row.getPhysicalNumberOfCells();
				        for(columnindex=0;columnindex<=13;columnindex++){		        	
				            //셀값을 읽는다
				            HSSFCell cell=row.getCell(columnindex);
				            String value="";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null){
				                continue;
				            }else{
				                //타입별로 내용 읽기
				                switch (cell.getCellType()){
				                case FORMULA:
				                    value=cell.getCellFormula() + "";
				                    break;
				                case NUMERIC:
				                	
									if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}
				                    
				                    break;
				                case STRING:
				                    value=cell.getStringCellValue()+"";
				                    break;
				                case BLANK:
				                    value="";
				                    break;
				                case ERROR:
				                    value=cell.getErrorCellValue()+"";
				                    break;
				                }
				           		              
				            
				            switch(columnindex) {
				            	case 0:
				            		try {
					            		vo[rowindex-1].setPartCd(value.replaceAll(",",""));
									}catch (NumberFormatException e) {
										vo[rowindex-1].setPartCd("");
					            	}
					            	break;
					            case 1:
					            	vo[rowindex-1].setPartNm(value);
					            	break;
					            case 2:
					            	vo[rowindex-1].setPartGubun(value);
					            	break;
					            case 3:
					            	vo[rowindex-1].setPartType(value);
					            	break;
					            case 4:
					            	vo[rowindex-1].setPartSpec(value);
					            	break;
					            case 5:
					            	try {
					            		vo[rowindex-1].setInCorpCd(value.replaceAll(",",""));
									}catch (NumberFormatException e) {
										vo[rowindex-1].setInCorpCd("");
					            	}
					            	break;		
					            case 6:
					            	vo[rowindex-1].setPartUnit(value);
					            	break;		
					            case 7:
					            	vo[rowindex-1].setBasicDlvDate(value);
					            	break;
					            case 8:
					            	try {
					            		vo[rowindex-1].setUnitCost(Integer.parseInt(value.replaceAll(",","")));
									}catch (NumberFormatException e) {
					            		vo[rowindex-1].setUnitCost(0);
					            	}
							    	// 셀데이터
					            	break;
					            case 9:
					            	vo[rowindex-1].setSafetyStockQty(value);
					            	break;
					            case 10:
					            	vo[rowindex-1].setBarcodeYn(value);
					            	break;
					            case 11:
					            	vo[rowindex-1].setUseYn(value);
					            	break;
					            case 12:
					            	vo[rowindex-1].setInspectYn(value);
					            	break;
					            case 13:
					            	vo[rowindex-1].setPartDesc(value);
					            	break;
				            }
				          }			           
				            
				        }
				        
				        if(!"".equals(vo[rowindex-1].getPartCd())&&!"".equals(vo[rowindex-1].getPartRev())){
				        	list.add(vo[rowindex-1]);
				        }
				        
				        
				        	      
				   }
				   	    
				}
				
				
				logger.info("list size = "+ list.size());
				
				return list;
			}
			else {
				logger.info(filename);
				
				fis= new FileInputStream(filename);
				workbook2= new XSSFWorkbook(fis);		
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex=0;
				int columnindex=0;
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				XSSFSheet sheet=workbook2.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
				
				for(rowindex=1;rowindex<rows;rowindex++){
				    //행을 읽는다
				    XSSFRow row=sheet.getRow(rowindex);
				    Row row2 = row;
					  
				    if(row !=null && !row2.getZeroHeight()){
				    	
						/*
						 * // 셀데이터 확인 로직 추가 21-02-25 //셀 데이터 확인 boolean checkCell = false; //셀 데이터 전체가
						 * 공백일경우 체크 for(columnindex=0;columnindex<=14;columnindex++){ XSSFCell
						 * cell=row.getCell(columnindex); //셀 데이터 전체가 공백일경우 체크
						 * System.out.println(rowindex); switch (cell.getCellType()){ //공백일경우 다음셀 확인
						 * case BLANK: break; //공백이 아닐경우 체크로직 중단 default: checkCell=true; break; } //공백이
						 * 아닌셀이 발견될경우 체크로직 중단 if(checkCell) { break; } } //전체 공백인경우 메인 row 루프 중단
						 * if(!checkCell) { break; } // 셀데이터 확인 로직 추가 21-02-25
						 */		                
				        //셀의 수
				    	ItemPartAdmVo[] vo = new ItemPartAdmVo[rows];
				    	vo[rowindex-1] = new ItemPartAdmVo();
				        int cells=row.getPhysicalNumberOfCells();
				        for(columnindex=0;columnindex<=13;columnindex++){
				            //셀값을 읽는다
				            XSSFCell cell=row.getCell(columnindex);
				           
				            String value="";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null){
				                continue;
				            }else{
				            	 logger.info(""+cell.getCellType());
				            	 
				                //타입별로 내용 읽기
				                switch (cell.getCellType()){
				                case FORMULA:
				                    value=cell.getCellFormula() + "";
				                    break;
				                case NUMERIC:		
				                	if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
				                case STRING:
				                    value=cell.getStringCellValue()+"";
				                    break;
				                case BLANK:
				                    value="";
				                    break;
				                case ERROR:
				                    value=cell.getErrorCellValue()+"";
				                    break;
				                }
				                switch(columnindex) {
				                case 0:
				            		try {
					            		vo[rowindex-1].setPartCd(value.replaceAll(",",""));
									}catch (NumberFormatException e) {
										vo[rowindex-1].setPartCd("");
					            	}
					            	break;
					            case 1:
					            	vo[rowindex-1].setPartNm(value);
					            	break;
					            case 2:
					            	vo[rowindex-1].setPartGubun(value);
					            	break;
					            case 3:
					            	vo[rowindex-1].setPartType(value);
					            	break;
					            case 4:
					            	vo[rowindex-1].setPartSpec(value);
					            	break;
					            case 5:
					            	try {
					            		vo[rowindex-1].setInCorpCd(value.replaceAll(",",""));
									}catch (NumberFormatException e) {
										vo[rowindex-1].setInCorpCd("");
					            	}
					            	break;		
					            case 6:
					            	vo[rowindex-1].setPartUnit(value);
					            	break;		
					            case 7:
					            	vo[rowindex-1].setBasicDlvDate(value);
					            	break;
					            case 8:
					            	try {
					            		vo[rowindex-1].setUnitCost(Integer.parseInt(value.replaceAll(",","")));
									}catch (NumberFormatException e) {
					            		vo[rowindex-1].setUnitCost(0);
					            	}
							    	// 셀데이터
					            	break;
					            case 9:
					            	vo[rowindex-1].setSafetyStockQty(value);
					            	break;
					            case 10:
					            	vo[rowindex-1].setBarcodeYn(value);
					            	break;
					            case 11:
					            	vo[rowindex-1].setUseYn(value);
					            	break;
					            case 12:
					            	vo[rowindex-1].setInspectYn(value);
					            	break;
					            case 13:
					            	vo[rowindex-1].setPartDesc(value);
					            	break;
					          
				            }
				          }
				            
				        } 
				        if(!"".equals(vo[rowindex-1].getPartCd())&&!"".equals(vo[rowindex-1].getPartRev())){
				        	list.add(vo[rowindex-1]);
				        }
				        
				   }
				   	    
				}
				
				
				logger.info("list size = "+ list.size());
				
				
			}
		} catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            
        } finally {
            try {
                // 사용한 자원은 finally에서 해제
                if( workbook!= null) { workbook.close();}
                if( workbook2!= null) { workbook2.close();}
                if( fis!= null) {fis.close();}
                
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		logger.info("엑셀 list"+list);
		return list;
	} 
	
	//LOT&Barcode 엑셀 업로드
	public List<ReservationVo> reservation_fileload(String filename, Logger logger) throws IOException {
		logger.info("filename = "+ filename);
		int pos					= filename.lastIndexOf( "." );
		String ext				= filename.substring( pos + 1 );
		FileInputStream fis		= null; 
		HSSFWorkbook workbook	= null;
		XSSFWorkbook workbook2	= null;
		List<ReservationVo> list = new ArrayList<ReservationVo>();	
		try {
			if(ext.equals("xls")) {
				fis			= new FileInputStream(filename);
				workbook	= new HSSFWorkbook(fis);			
					
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex=0;
				int columnindex=0;
				
				boolean cellCheck = false;
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				HSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
						
				for(rowindex=1;rowindex<rows;rowindex++){
					cellCheck = false;
					//행을 읽는다
				    HSSFRow row=sheet.getRow(rowindex);
				    if(row !=null){
				    	//셀의 수
				    	ReservationVo[] vo 	= new ReservationVo[rows];
				    	vo[rowindex-1] 			= new ReservationVo();
				        int cells				= row.getPhysicalNumberOfCells();
				        
//				        loop:
//				        for(columnindex=0;columnindex<=1;columnindex++) {
				            //셀값을 읽는다
//				            HSSFCell cell	= row.getCell(columnindex);
				            HSSFCell cell	= row.getCell(0);
				            String value	= "";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
				                continue;
				            }else{
				            	//타입별로 내용 읽기
				                switch (cell.getCellType()){
					                case FORMULA:
					                	value=cell.getCellFormula() + "";
					                break;
					                
					                case NUMERIC:
									if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}
				                    break;
				                    
					                case STRING:
					                	value=cell.getStringCellValue()+"";
					                break;
					                
					                case BLANK:
					                	//value=cell.getBooleanCellValue()+"";
					                	value = "";
					                break;
					                
					                case ERROR:
					                	value=cell.getErrorCellValue()+"";
					                break;
				                }
				                /*switch(columnindex) {
					            	case 0:
						            	vo[rowindex-1].setLotNo(value);
						            	cellCheck = true;
						            break;
				                }*/
				                
				                vo[rowindex-1].setLotNo(value);
				            	cellCheck = true;
				            	
				            }
//				        }
				        if(cellCheck) {
				        	list.add(vo[rowindex-1]);
				        } else {
				        	break;
				        }
				    }
				}
				logger.info("list size = "+ list.size());
			}else {
				fis					= new FileInputStream(filename);
				workbook2 			= new XSSFWorkbook(fis);
				DecimalFormat df	= new DecimalFormat();
				 
				int rowindex	= 0;
				int columnindex	= 0;
				
				boolean cellCheck = false;
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				XSSFSheet sheet = workbook2.getSheetAt(0);
				//행의 수
				int rows = sheet.getPhysicalNumberOfRows();
				
				logger.info("rows값 확인 --> "+rows);
				
//				loop:
				for(rowindex=1;rowindex<rows;rowindex++){
					cellCheck = false;
				    //행을 읽는다
				    XSSFRow row = sheet.getRow(rowindex);
				    
				    logger.info("row값 확인 --> "+row);
				    
				    if(row !=null){
				        //셀의 수
				    	ReservationVo[] vo 	= new ReservationVo[rows];
				    	vo[rowindex-1] 		= new ReservationVo();
				        int cells			= row.getPhysicalNumberOfCells(); 
				        
//				        for(columnindex=0;columnindex<=1;columnindex++) {
				            //셀값을 읽는다
//				            XSSFCell cell	= row.getCell(columnindex);
				            XSSFCell cell	= row.getCell(0);
				            String value	= "";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
				            	continue;
				            }else {
				            	//타입별로 내용 읽기
				                switch (cell.getCellType()){
					                case FORMULA:
					                    value=cell.getCellFormula() + "";
				                    break;
					                case NUMERIC:
				                	if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
					                case STRING:
					                	value=cell.getStringCellValue()+"";
				                    break;
					                case BLANK:
					                	//value=cell.getBooleanCellValue()+"";
					                	value = "";
				                    break;
					                case ERROR:
					                	value=cell.getErrorCellValue()+"";
				                    break;
				                }
					            /*switch(columnindex) {
					            	case 0:
					            		vo[rowindex-1].setLotNo(value);
						            	cellCheck = true;
						            break;
					            }*/
				                
				                vo[rowindex-1].setLotNo(value);
				            	cellCheck = true;
				            }
//				        }
				        if(cellCheck) {
				        	list.add(vo[rowindex-1]);
				        }else {
				        	break;
				        }
				    }
				}
				logger.info("list size = "+ list.size());
			}
		} catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                // 사용한 자원은 finally에서 해제
                if( workbook!= null) { workbook.close();}
                if( workbook2!= null) { workbook2.close();}
                if( fis!= null) {fis.close();}
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		return list;
	}
	
	//포장리스트 엑셀 업로드
	public List<PurchaseOrderAdmVo> multiRetv_fileload(String filename, Logger logger) throws IOException {
		logger.info("filename = "+ filename);
		int pos					= filename.lastIndexOf( "." );
		String ext				= filename.substring( pos + 1 );
		FileInputStream fis		= null; 
		HSSFWorkbook workbook	= null;
		XSSFWorkbook workbook2	= null;
		List<PurchaseOrderAdmVo> list = new ArrayList<PurchaseOrderAdmVo>();	
		try {
			if(ext.equals("xls")) {
				fis			= new FileInputStream(filename);
				workbook	= new HSSFWorkbook(fis);			
					
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex=0;
				int columnindex=0;
				
				boolean cellCheck = false;
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				HSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
						
				for(rowindex=1;rowindex<rows-2;rowindex++){
					cellCheck = false;
					//행을 읽는다
				    HSSFRow row=sheet.getRow(rowindex+1);
				    if(row !=null){
				    	//셀의 수
				    	PurchaseOrderAdmVo[] vo 	= new PurchaseOrderAdmVo[rows-2];
				    	vo[rowindex-1] 			= new PurchaseOrderAdmVo();
				        int cells				= row.getPhysicalNumberOfCells();
				        
//					        loop:
//					        for(columnindex=0;columnindex<=1;columnindex++) {
				            //셀값을 읽는다
//					            HSSFCell cell	= row.getCell(columnindex);
				            HSSFCell cell	= row.getCell(0);
				            HSSFCell cell1	= row.getCell(1);
				            HSSFCell cell2	= row.getCell(2);
				            HSSFCell cell3	= row.getCell(3);
				            String value	= "";
				            String value1	= "";
				            String value2	= "";
				            String value3	= "";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
				            	value = "";
				            }else{
				            	//타입별로 내용 읽기
				                switch (cell.getCellType()){
					                case FORMULA:
					                	value=cell.getCellFormula() + "";
					                break;
					                
					                case NUMERIC:
									if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}
				                    break;
				                    
					                case STRING:
					                	value=cell.getStringCellValue()+"";
					                break;
					                
					                case BLANK:
					                	value=cell.getBooleanCellValue()+"";
					                break;
					                
					                case ERROR:
					                	value=cell.getErrorCellValue()+"";
					                break;
				                }
				                
				                switch (cell1.getCellType()){
					                case FORMULA:
					                	value=cell1.getCellFormula() + "";
					                break;
					                
					                case NUMERIC:
									if(DateUtil.isCellDateFormatted(cell1)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value1 = formatter.format(cell1.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell1.getNumericCellValue();
				                		value1 = df.format(ddata) + "";
				                	}
				                    break;
				                    
					                case STRING:
					                	value1=cell1.getStringCellValue()+"";
					                break;
					                
					                case BLANK:
					                	value1=cell1.getBooleanCellValue()+"";
					                break;
					                
					                case ERROR:
					                	value1=cell1.getErrorCellValue()+"";
					                break;
				                }
				                
				                switch (cell2.getCellType()){
					                case FORMULA:
					                	value2=cell2.getCellFormula() + "";
					                break;
					                
					                case NUMERIC:
									if(DateUtil.isCellDateFormatted(cell2)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value2 = formatter.format(cell2.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell2.getNumericCellValue();
				                		value2 = df.format(ddata) + "";
				                	}
				                    break;
				                    
					                case STRING:
					                	value2=cell2.getStringCellValue()+"";
					                break;
					                
					                case BLANK:
					                	value2=cell2.getBooleanCellValue()+"";
					                break;
					                
					                case ERROR:
					                	value2=cell2.getErrorCellValue()+"";
					                break;
				                }
				                
				                switch (cell3.getCellType()){
					                case FORMULA:
					                	value3=cell3.getCellFormula() + "";
					                break;
					                
					                case NUMERIC:
									if(DateUtil.isCellDateFormatted(cell3)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value3 = formatter.format(cell3.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell3.getNumericCellValue();
				                		value3 = df.format(ddata) + "";
				                	}
				                    break;
				                    
					                case STRING:
					                	value3=cell3.getStringCellValue()+"";
					                break;
					                
					                case BLANK:
					                	value3=cell3.getBooleanCellValue()+"";
					                break;
					                
					                case ERROR:
					                	value3=cell3.getErrorCellValue()+"";
					                break;
				                }
				                /*switch(columnindex) {
					            	case 0:
						            	vo[rowindex-1].setLotNo(value);
						            	cellCheck = true;
						            break;
				                }*/
				                
				                vo[rowindex-1].setBoxNo(value);
				                vo[rowindex-1].setMatrlLotNo(value1);
				                vo[rowindex-1].setFilmLotNo(value2);
				                vo[rowindex-1].setCustomerLotNo(value3);
				            	cellCheck = true;
				            	
				            }
//					        }
				        if(cellCheck) {
				        	list.add(vo[rowindex-1]);
				        } else {
				        	break;
				        }
				    }
				}
				logger.info("list size = "+ list.size());
			}else {
				fis					= new FileInputStream(filename);
				workbook2 			= new XSSFWorkbook(fis);
				DecimalFormat df	= new DecimalFormat();
				 
				int rowindex	= 0;
				int columnindex	= 0;
				
				boolean cellCheck = false;
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				XSSFSheet sheet = workbook2.getSheetAt(0);
				//행의 수
				int rows = sheet.getPhysicalNumberOfRows();
				
				logger.info("rows값 확인 --> "+rows);
				
//					loop:
				for(rowindex=1;rowindex<rows-1;rowindex++){
					cellCheck = false;
				    //행을 읽는다
				    XSSFRow row = sheet.getRow(rowindex+1);
				    
				    logger.info("row값 확인 --> "+row);
				    
				    if(row !=null){
				        //셀의 수
				    	PurchaseOrderAdmVo[] vo 	= new PurchaseOrderAdmVo[rows-2];
				    	vo[rowindex-1] 		= new PurchaseOrderAdmVo();
				        int cells			= row.getPhysicalNumberOfCells(); 
				        
//					        for(columnindex=0;columnindex<=1;columnindex++) {
				            //셀값을 읽는다
//					            XSSFCell cell	= row.getCell(columnindex);
				            XSSFCell cell	= row.getCell(0);
				            XSSFCell cell1	= row.getCell(1);
				            XSSFCell cell2	= row.getCell(2);
				            XSSFCell cell3	= row.getCell(3);
				            
				            String value	= "";
				            String value1	= "";
				            String value2	= "";
				            String value3	= "";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
				            	value = "";
				            }else {
				            	//타입별로 내용 읽기
				                switch (cell.getCellType()){
					                case FORMULA:
					                    value=cell.getCellFormula() + "";
				                    break;
					                case NUMERIC:
				                	if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
					                case STRING:
					                	value=cell.getStringCellValue()+"";
				                    break;
					                case BLANK:
					                	value=cell.getBooleanCellValue()+"";
				                    break;
					                case ERROR:
					                	value=cell.getErrorCellValue()+"";
				                    break;
				                }
				                
				                vo[rowindex-1].setBoxNo(value);
				            }
				                
				            if(cell1==null || cell1.equals("") || cell1.equals(" ") || cell1.toString().isEmpty()){
				            	value1 = "";
				            }else {
				                switch (cell1.getCellType()){
					                case FORMULA:
					                    value1=cell1.getCellFormula() + "";
				                    break;
					                case NUMERIC:
				                	if(DateUtil.isCellDateFormatted(cell1)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value1 = formatter.format(cell1.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell1.getNumericCellValue();
				                		value1 = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
					                case STRING:
					                	value1=cell1.getStringCellValue()+"";
				                    break;
					                case BLANK:
					                	value1=cell1.getBooleanCellValue()+"";
				                    break;
					                case ERROR:
					                	value1=cell1.getErrorCellValue()+"";
				                    break;
				                }
				                vo[rowindex-1].setMatrlLotNo(value1);
				            }
				                
				            if(cell2==null || cell2.equals("") || cell2.equals(" ") || cell2.toString().isEmpty()){
				            	value2 = "";
				            }else {
				                switch (cell2.getCellType()){
					                case FORMULA:
					                    value2=cell2.getCellFormula() + "";
				                    break;
					                case NUMERIC:
				                	if(DateUtil.isCellDateFormatted(cell2)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value2 = formatter.format(cell2.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell2.getNumericCellValue();
				                		value2 = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
					                case STRING:
					                	value2=cell2.getStringCellValue()+"";
				                    break;
					                case BLANK:
					                	value2=cell2.getBooleanCellValue()+"";
				                    break;
					                case ERROR:
					                	value2=cell2.getErrorCellValue()+"";
				                    break;
				                }
				                vo[rowindex-1].setFilmLotNo(value2);
				            }
				                
				            if(cell3==null || cell3.equals("") || cell3.equals(" ") || cell3.toString().isEmpty()){
				            	value3 = "";
				            }else {
				                switch (cell3.getCellType()){
					                case FORMULA:
					                    value3=cell3.getCellFormula() + "";
				                    break;
					                case NUMERIC:
				                	if(DateUtil.isCellDateFormatted(cell3)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value3 = formatter.format(cell3.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell3.getNumericCellValue();
				                		value3 = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
					                case STRING:
					                	value3=cell3.getStringCellValue()+"";
				                    break;
					                case BLANK:
					                	value3=cell3.getBooleanCellValue()+"";
				                    break;
					                case ERROR:
					                	value3=cell3.getErrorCellValue()+"";
				                    break;
				                }
				                vo[rowindex-1].setCustomerLotNo(value3);
				            }
					            /*switch(columnindex) {
					            	case 0:
					            		vo[rowindex-1].setLotNo(value);
						            	cellCheck = true;
						            break;
					            }*/
//					        }
				        	list.add(vo[rowindex-1]);
				    }
				}
				logger.info("list size = "+ list.size());
				logger.info("list = "+ list);
			}
		} catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                // 사용한 자원은 finally에서 해제
                if( workbook!= null) { workbook.close();}
                if( workbook2!= null) { workbook2.close();}
                if( fis!= null) {fis.close();}
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		return list;
	}
	
	
	
	
	
	//도금두께 엑셀 업로드
	public List<ReservationVo> plated_fileload(String filename, Logger logger) throws IOException {
		logger.info("filename = "+ filename);
		int pos					= filename.lastIndexOf( "." );
		String ext				= filename.substring( pos + 1 );
		FileInputStream fis		= null; 
		HSSFWorkbook workbook	= null;
		XSSFWorkbook workbook2	= null;
		List<ReservationVo> list = new ArrayList<ReservationVo>();	
		try {
			if(ext.equals("xls")) {
				fis			= new FileInputStream(filename);
				workbook	= new HSSFWorkbook(fis);			
					
				DecimalFormat df = new DecimalFormat();
				 
				int rowindex=0;
				int columnindex=0;
				
				boolean cellCheck = false;
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				HSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
						
				for(rowindex=1;rowindex<rows;rowindex++){
					cellCheck = false;
					//행을 읽는다
				    HSSFRow row=sheet.getRow(rowindex);
				    if(row !=null){
				    	//셀의 수
				    	ReservationVo[] vo 	= new ReservationVo[rows];
				    	vo[rowindex-1] 			= new ReservationVo();
				        int cells				= row.getPhysicalNumberOfCells();
				        
//					        loop:
					        for(columnindex=0;columnindex<=1;columnindex++) {
					            //셀값을 읽는다
					        	HSSFCell cell	= row.getCell(columnindex);
					            //HSSFCell cell	= row.getCell(0);
					            String value	= "";
					            //셀이 빈값일경우를 위한 널체크
					            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
					                continue;
					            }else{
					            	//타입별로 내용 읽기
					                switch (cell.getCellType()){
						                case FORMULA:
						                	value=cell.getCellFormula() + "";
						                break;
						                
						                case NUMERIC:
										if(DateUtil.isCellDateFormatted(cell)) {
					                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					                		value = formatter.format(cell.getDateCellValue()) + "";
					                	} else {
					                		double ddata = cell.getNumericCellValue();
					                		value = df.format(ddata) + "";
					                	}
					                    break;
					                    
						                case STRING:
						                	value = cell.getStringCellValue()+"";
						                break;
						                
						                case BLANK:
						                	//value=cell.getBooleanCellValue()+"";
						                	value = "";
						                break;
						                
						                case ERROR:
						                	value = cell.getErrorCellValue()+"";
						                break;
					                }
					                
					                switch(columnindex) {
						            	case 0:
						            		vo[rowindex-1].setLotNo(value);
							            	cellCheck = true;
							            break;
						            	case 1:
						            		vo[rowindex-1].setThicknessQty(value);
							            	cellCheck = true;
							            break;
						            }
					                
					                /*vo[rowindex-1].setLotNo(value);
					            	cellCheck = true;*/
					            }
					        }
				        if(cellCheck) {
				        	list.add(vo[rowindex-1]);
				        } else {
				        	break;
				        }
				    }
				}
				logger.info("list size = "+ list.size());
			} else {
				fis					= new FileInputStream(filename);
				workbook2 			= new XSSFWorkbook(fis);
				DecimalFormat df	= new DecimalFormat();
				 
				int rowindex	= 0;
				int columnindex	= 0;
				
				boolean cellCheck = false;
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				XSSFSheet sheet = workbook2.getSheetAt(0);
				//행의 수
				int rows = sheet.getPhysicalNumberOfRows();
				
				logger.info("rows값 확인 --> "+rows);
				
//					loop:
				for(rowindex=1;rowindex<rows;rowindex++){
					cellCheck = false;
				    //행을 읽는다
				    XSSFRow row = sheet.getRow(rowindex);
				    
				    logger.info("row값 확인 --> "+row);
				    
				    if(row !=null){
				        //셀의 수
				    	ReservationVo[] vo 	= new ReservationVo[rows];
				    	vo[rowindex-1] 		= new ReservationVo();
				        int cells			= row.getPhysicalNumberOfCells(); 
				        
				        for(columnindex=0;columnindex<=1;columnindex++) {
				            //셀값을 읽는다
				            XSSFCell cell	= row.getCell(columnindex);
				            //XSSFCell cell	= row.getCell(0);
				            String value	= "";
				            //셀이 빈값일경우를 위한 널체크
				            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
				            	continue;
				            }else {
				            	//타입별로 내용 읽기
				                switch (cell.getCellType()){
					                case FORMULA:
					                    value=cell.getCellFormula() + "";
				                    break;
					                case NUMERIC:
				                	if(DateUtil.isCellDateFormatted(cell)) {
				                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				                		value = formatter.format(cell.getDateCellValue()) + "";
				                	} else {
				                		double ddata = cell.getNumericCellValue();
				                		value = df.format(ddata) + "";
				                	}            
				                			                	
				                    break;
					                case STRING:
					                	value = cell.getStringCellValue()+"";
				                    break;
					                case BLANK:
					                	//value=cell.getBooleanCellValue()+"";
					                	value = "";
				                    break;
					                case ERROR:
					                	value = cell.getErrorCellValue()+"";
				                    break;
				                }
				                
					            switch(columnindex) {
					            	case 0:
					            		vo[rowindex-1].setLotNo(value);
						            	cellCheck = true;
						            break;
					            	case 1:
					            		vo[rowindex-1].setThicknessQty(value);
						            	cellCheck = true;
						            break;
					            }
				                
				                /*vo[rowindex-1].setLotNo(value);
				            	cellCheck = true;*/
				            }
				        }
				        if(cellCheck) {
				        	list.add(vo[rowindex-1]);
				        }else {
				        	break;
				        }
				    }
				}
				logger.info("list size = "+ list.size());
			}
		} catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                // 사용한 자원은 finally에서 해제
                if( workbook!= null) { workbook.close();}
                if( workbook2!= null) { workbook2.close();}
                if( fis!= null) {fis.close();}
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
		return list;
	}
	
	
	//도금두께 엑셀 업로드
		public List<String> monthPlan_fileload(String filename, Logger logger) throws IOException {
			logger.info("filename = "+ filename);
			int pos					= filename.lastIndexOf( "." );
			String ext				= filename.substring( pos + 1 );
			FileInputStream fis		= null; 
			HSSFWorkbook workbook	= null;
			XSSFWorkbook workbook2	= null;
			List<String> list = new ArrayList<>();	
			try {
				if(ext.equals("xls")) {
					fis			= new FileInputStream(filename);
					workbook	= new HSSFWorkbook(fis);			
						
					DecimalFormat df = new DecimalFormat();
					 
					int rowindex=0;
					int columnindex=0;
					
					boolean cellCheck = false;
					
					//시트 수 (첫번째에만 존재하므로 0을 준다)
					//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
					HSSFSheet sheet=workbook.getSheetAt(0);
					//행의 수
					int rows=sheet.getPhysicalNumberOfRows();
							
					for(rowindex=1;rowindex<rows;rowindex++){
						cellCheck = false;
						//행을 읽는다
					    HSSFRow row=sheet.getRow(rowindex);
					    if(row !=null){
					    	//셀의 수
					        int cells = row.getPhysicalNumberOfCells();
					        
//						        loop:
						        for(columnindex=0;columnindex<=cells;columnindex++) {
						            //셀값을 읽는다
						        	HSSFCell cell	= row.getCell(columnindex);
						            //HSSFCell cell	= row.getCell(0);
						            String value	= "";
						            //셀이 빈값일경우를 위한 널체크
						            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
						            	list.add("");
						                continue;
						            }else{
						            	//타입별로 내용 읽기
						                switch (cell.getCellType()){
							                case FORMULA:
							                	value=cell.getCellFormula() + "";
							                break;
							                
							                case NUMERIC:
											if(DateUtil.isCellDateFormatted(cell)) {
						                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
						                		value = formatter.format(cell.getDateCellValue()) + "";
						                	} else {
						                		double ddata = cell.getNumericCellValue();
						                		value = df.format(ddata) + "";
						                	}
						                    break;
						                    
							                case STRING:
							                	value = cell.getStringCellValue()+"";
							                break;
							                
							                case BLANK:
							                	//value=cell.getBooleanCellValue()+"";
							                	value = "";
							                break;
							                
							                case ERROR:
							                	value = cell.getErrorCellValue()+"";
							                break;
						                }
						                if(columnindex==0) {
						                	continue;
						                } else {
						                	list.add(value);
						                }
						            }
						        }

					    }
					}
					logger.info("list size = "+ list.size());
				} else {
					fis					= new FileInputStream(filename);
					workbook2 			= new XSSFWorkbook(fis);
					DecimalFormat df	= new DecimalFormat();
					 
					int rowindex	= 0;
					int columnindex	= 0;
					
					boolean cellCheck = false;
					
					//시트 수 (첫번째에만 존재하므로 0을 준다)
					//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
					XSSFSheet sheet = workbook2.getSheetAt(0);
					//행의 수
					int rows = sheet.getPhysicalNumberOfRows();
					
					logger.info("rows값 확인 --> "+rows);
					
//						loop:
					for(rowindex=1;rowindex<rows;rowindex++){
						cellCheck = false;
					    //행을 읽는다
					    XSSFRow row = sheet.getRow(rowindex);
					    
					    logger.info("row값 확인 --> "+row);
					    
					    if(row !=null){
					        //셀의 수
					        int cells			= row.getPhysicalNumberOfCells(); 
					        
					        for(columnindex=0;columnindex<=cells;columnindex++) {
					            //셀값을 읽는다
					            XSSFCell cell	= row.getCell(columnindex);
					            //XSSFCell cell	= row.getCell(0);
					            String value	= "";
					            //셀이 빈값일경우를 위한 널체크
					            if(cell==null || cell.equals("") || cell.equals(" ") || cell.toString().isEmpty()){
					            	list.add("");
					            	continue;
					            }else {
					            	//타입별로 내용 읽기
					                switch (cell.getCellType()){
						                case FORMULA:
						                    value=cell.getCellFormula() + "";
					                    break;
						                case NUMERIC:
					                	if(DateUtil.isCellDateFormatted(cell)) {
					                		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					                		value = formatter.format(cell.getDateCellValue()) + "";
					                	} else {
					                		double ddata = cell.getNumericCellValue();
					                		value = df.format(ddata) + "";
					                	}            
					                			                	
					                    break;
						                case STRING:
						                	value = cell.getStringCellValue()+"";
					                    break;
						                case BLANK:
						                	//value=cell.getBooleanCellValue()+"";
						                	value = "";
					                    break;
						                case ERROR:
						                	value = cell.getErrorCellValue()+"";
					                    break;
					                    
					                   
					                }
					                if(columnindex==0) {
					                	continue;
					                } else {
					                	list.add(value);
					                }
					            }
					        }
					    }
					}
					logger.info("list size = "+ list.size());
				}
			} catch (FileNotFoundException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } finally {
	            try {
	                // 사용한 자원은 finally에서 해제
	                if( workbook!= null) { workbook.close();}
	                if( workbook2!= null) { workbook2.close();}
	                if( fis!= null) {fis.close();}
	            } catch (IOException e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            }
	        }
			return list;
		}
	
}