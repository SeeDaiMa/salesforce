public  class MyFirstCtl {

    // bug1 ： 当keyword改变的时候，不搜索，它也会改变最大的页面数
    // bug2 :  abc  
    public List<Account> accs {get;set;}
    public String keyWord {get;set;}
    public String aName {get;set;}
    public Integer currentPage {get;set;}
    public Integer maxCurrentPage{get;set;}
    // 设置是否精确搜索
    public Boolean isPrecise{get;set;}
    // 页面的大小
    public static final Integer pageSize = 5; 


    public MyFirstCtl() {
       // keyWord 初始化的时候是null  
        keyWord='';
        dynamicSearch();
        //inited();
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
        String sql = 'select id,name,AccountNumber,AccountSource,Type,Website from account where name like :aName ';
        accs = Database.query(sql);
        Integer sum = accs.size();
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
        String sql = 'select id,name,AccountNumber,AccountSource,Type,Website from account where name like :aName limit :pageSize offset :i';
        System.debug('sql: '+sql);
        accs = Database.query(sql);
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