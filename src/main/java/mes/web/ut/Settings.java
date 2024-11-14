package mes.web.ut;

//java 싱글톤 static inner 방법, 직렬화&역직렬화 사용하지 않기!
public class Settings {
	
	public boolean useGoodsPacking = false;		//제품 포장여부
	public boolean useMatrlInout = false;		//자재 엑셀 가입고 여부
	public boolean useTrayProduce = false;		//트레이 생산 기능
	public String useTrayProduceArray [] = new String[100];		//트레이 생산 기능(작지 별로 싱글톤 적용)
	
	public boolean lockGoodsPacking = false;	//제품 포장기능 Lock
	public boolean lockTrayProduce = false;		//트레이 생산 기능 Lock
	
	private Settings() {}
	
	//SettingsHolder를 통해서만 인스턴스 생성
	private static class SettingsHolder {
		private static final Settings INSTANCE = new Settings();
	}
	
	public static Settings getInstance() {
		return SettingsHolder.INSTANCE;
	}
	
}