public without sharing class MathHelper {
    
    /*
        是否整除
        @param dividend 被除数
        @param divider  除数
        @return 整除返回true，不整除返回false
    */
    public static Boolean isDivisibility(Integer dividend,Integer divider) {
        //先将被除数转换成Decimal，否则先计算整数除法结果为Integer类型，然后将整数转换成Decimal
        Decimal resultDecimal = Decimal.valueOf(dividend) / divider;
        //获取结果上线
        Integer resultSeiling = Integer.valueOf(resultDecimal.round(System.RoundingMode.CEILING));
        Integer resultDown = Integer.valueOf(resultDecimal.round(System.RoundingMode.DOWN));
        
        return resultSeiling == resultDown;
    }
    
    /*
        获取余数
        @param dividend 被除数
        @param divider  除数
        @return 返回余数
    */
    public static Integer getRemainder(Integer dividend,Integer divider) {
        Decimal resultDecimal = Decimal.valueOf(dividend) / divider;
        Integer resultDown = Integer.valueOf(resultDecimal.round(System.RoundingMode.DOWN));
        return dividend - resultDown * divider;
    } 
}