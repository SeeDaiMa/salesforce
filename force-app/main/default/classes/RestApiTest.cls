@RestResource(urlMapping ='/sap/product')
global with sharing class RestApiTest {
    public RestApiTest() {

    }

    
    @HttpPost
    global static void test(){
        // 结果集
        List<ResonseBodyResult> results = new  List<ResonseBodyResult>();
        
        RestRequest request = RestContext.request;
        System.debug('request' + request.requestBody.tostring());
        // json 反序列化
         dateDetail resbody = (dateDetail)JSON.deserialize(request.requestBody.tostring(), dateDetail.class);                               
        //产品名字集合
        List<String> productNameList = new  List<String>();
        // 得到所有的productName
        for (cls_entity entity : resbody.entity) {
            productNameList.add(entity.productName);
        }
        //pds批量更新的操作
        List<Product2> pds = new List<Product2>();
        // 可以查到数据的product2的map
        Map<id,String> maps = new Map<Id,String>();
        // productCode set
        Set<String> codeSet = new Set<String>();

        for (Product2 pd : [select id,
                                name,
                                productCode,
                                isActive,
                                description 
                            from Product2  
                            where name in :productNameList]) {
            pds.add(pd);
        }
        
        System.debug('查询的集合size:'+pds.size());
        System.debug('查询的集合的值'+pds);

        // 放进 id,productName 的map中
        for (Product2 pd : pds) {
            maps.put(pd.id, pd.ProductCode);
        }
        // 添加所有的productCode
        for (cls_entity entity : resbody.entity) {
            codeSet.add(entity.productCode);
        }
        // 遍历所有的productCode
        for (String code : codeSet) {
            ResonseBodyResult result =    new ResonseBodyResult();
            // 没有查到的product
            if(!maps.values().contains(code)) {
               result.status = '001';
               result.productCode = code;
               result.msg = '没有找到product2对象';
               results.add(result);
            }
            
        }

        if(pds.size()>0){
            // 批处理更新product
            Database.SaveResult[] resultList =  Database.update(pds,false);
            for (Database.SaveResult s : resultList) {
                ResonseBodyResult result = new ResonseBodyResult();
                if(s.isSuccess()) {
                       result.msg = 'success';
                       result.productCode = maps.get(s.id);
                       result.status = '000';
                }else {
                    // 发生错误
                    for(Database.Error err : s.getErrors()) {
                        result.productCode = maps.get(s.id);
                        result.msg = err.message;
                        result.status = '001';
                    }
                }
                results.add(result);
            }       
                
        }
        String locationJSON = json.serialize(results);
        RestContext.response.responseBody = Blob.valueOf(locationJSON);
       
        
    }





    public class dateDetail{
        public String method;    //velit sint
        public List<cls_entity> entity;
    }

    class cls_entity{
        public String productName;   
        public String productCode; 
        public Boolean isActive;    
        public String description;    
    }


    public class ResonseBodyResult{
        public String productCode;
        public String status;
        public String msg;

    }
}