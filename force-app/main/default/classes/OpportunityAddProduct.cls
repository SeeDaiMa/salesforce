public with sharing class OpportunityAddProduct {
   
    /**
     *  PricebookEntry 价格手册条目
     *  Product2   产品
     *  不考虑其他的货币的转换
     */

    //select id,name,Product2Id,ProductCode,
    //(select name,ProductCode,Description,Type from Product2 where Id = Pricebook2Id) from PricebookEntry 

    public OpportunityAddProduct() {
    // keyWord 初始化的时候是null  
    keyWord='';
    dynamicSearch();
     //inited();
     optionPes =new List<PricebookEntry>();
     optionPes.add(new PricebookEntry());
    }

    // bug1 ： 当keyword改变的时候，不搜索，它也会改变最大的页面数
    // bug2 :  abc  
    // 价格手册条目
    public List<PricebookEntry> pes {get;set;}
    // 产品
    // public List<Product2> pro2s {get;set;} 

    // public List<Sobject>  result {get;set;}

    public List<PricebookEntry> optionPes {get;set;}

    public String keyWord {get;set;}
    public String aName {get;set;}
    public Integer currentPage {get;set;}
    public Integer maxCurrentPage{get;set;}
    // 设置是否精确搜索
    public Boolean isPrecise{get;set;}
    // 页面的大小
    public static final Integer pageSize = 5; 


    public void choice(){

    }

    private  void setMaxCurrentPage(){
        String nCdt;
        if(isPrecise){
            // 精确
            nCdt = keyWord;
        }else{
            nCdt = '%'+keyWord+'%';
        }
        aName= nCdt;
        List<PricebookEntry> pes = [select id, //价格手册条目id
                                    name, // 产品名称
                                    UnitPrice, //价目表价格
                                    Product2.name, //产品名称 
                                    Product2.ProductCode, // 产品代码
                                    Product2.Description,// 产品描述
                                    Product2.Type // 产品类型
                                     from PricebookEntry
                                    where name like :nCdt];
        Integer sum = pes.size();
        // 但没有数据的时候就得
        if(sum == 0){
            maxCurrentPage = 1;
        }else if(MathHelper.isDivisibility(sum, pageSize)){
            maxCurrentPage = sum / pageSize;
        }else{
            maxCurrentPage = sum / pageSize + 1 ;
        }
        currentPage = 1;
        System.debug('maxCurrenPage'+maxCurrentPage);
    }
 
    // 动态模糊查询
    public void dynamicSearch() {
        isPrecise = false;
        // 重写设置最大页面
        setMaxCurrentPage();
        searchPage();
        // sql = '';// 清空sql条件语句
    }


    // 精确查询
    public void accurateSearch(){
        isPrecise = true;
        setMaxCurrentPage();
        searchPage();
    }

    private  void searchPage(){
        Integer i = (currentPage-1)*5; 

        pes =       [select id,
                    name, 
                    UnitPrice,
                    Product2.name,
                    Product2.ProductCode,
                    Product2.Description,
                    Product2.Type
                    from PricebookEntry
                    where name like :aName 
                    limit :pageSize offset :i];


       
    }
 



    
    public void  firstPage(){
        currentPage = 1;
        searchPage();
    }

    public void beforePage(){
        if(currentPage<=2){
            currentPage = 1;
        }else {
            currentPage--;
        }
        searchPage();
    }

    public void afterPage(){
        if(currentPage>=maxCurrentPage){
            currentPage = maxCurrentPage;
        }else {
            currentPage++;
        }
        searchPage();  
    }

    public void endPage(){
        currentPage = maxCurrentPage;
        searchPage(); 
    }

}