<php>$list = ff_mysql_news('cid:'.$list_id.';limit:10;page_is:true;page_id:list;page_p:'.$list_page.';cache_name:default;cache_time:default;order:news_addtime;sort:desc');
$page = ff_url_page('news/'.$action,array('id'=>$list_id,'list_dir'=>$list_dir,'p'=>'FFLINK'),true,'list',4);
$totalpages = ff_page_count('list', 'totalpages');
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>《<notempty name="list_title">{$list_title}<else/>{$list_name}</notempty>》First{$list_page}page_{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<body><include file="Home:header" />
<div class="container ff-bg ff-news news-list">
<div class="row">
	<div class="col-xs-12 ff-col">
  	<div class="page-header">
      <h4><span class="glyphicon glyphicon-pencil ff-text"></span> <a href="{:ff_url_news_show($list_id,$list_dir,1)}">{$list_name}</a>
      <small>Altogether<span class="ff-text">{:ff_page_count('list', 'records')}</span>Articles</small>
      </h4>
    </div>
    <volist name="list" id="feifei">
    <div class="row item">
      <div class="col-xs-8 col-sm-9">
        <h4>
          <a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_name'],$feifei['news_jumpurl'])}">
          {$feifei.news_name|msubstr=0,26,'utf-8',true}
          </a>
        </h4>
        <h6 class="text-muted">
          <span class="glyphicon glyphicon-eye-open"></span> {$feifei.news_hits|default='99'}
          <span class="glyphicon glyphicon-time"></span> {$feifei.news_addtime|date='Y-m-d',###}
        </h6>
      </div>
      <div class="col-xs-4 col-sm-3 text-center">
        <a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_name'],$feifei['news_jumpurl'],1)}">
        <img src="{:ff_url_img($feifei['news_pic'],$feifei['news_content'])}" class="img-responsive img-thumbnail" title="{$feifei.news_name}">
        </a>
      </div>
    </div>
    <div class="news-hr"></div>
    </volist>
    <gt name="totalpages" value="1">
      <div class="text-center">
        <ul class="pager">
          <gt name="list_page" value="1">
            <li><a href="{:ff_url_news_show($list_id,$list_dir,$list_page-1)}">Previous page</a></li>
          </gt>
          <lt name="list_page" value="$totalpages">
            <li><a href="{:ff_url_news_show($list_id,$list_dir,$list_page+1)}">Next page</a></li>
          </lt>
         </ul>
      </div>
    </gt>
  </div><!-- -->
  <div class="col-xs-12 ff-col">
  	<div class="page-header ff-border-none">
      <h4><span class="glyphicon glyphicon-th-list ff-text"></span> Related classification</h4>
    </div>
    <ul class="row list-unstyled text-center news-item-type">
      <volist name=":explode(',',$list_extend['type'])" id="feifei" offset="0" length='12'>
      <li class="col-xs-4">
        <a href="{:ff_url('news/type',array('type'=>urlencode($feifei),'id'=>$list_id,'p'=>1),true)}" class="btn btn-sm btn-default btn-block">{$feifei}</a>
      </li>
      </volist>
    </ul>
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header ff-border-none">
      <h4><span class="glyphicon glyphicon-signal ff-text"></span> Popular{$list_name}</h4>
    </div>
    <ol class="news-item-hot">
      <volist name=":ff_mysql_news('cid:'.$list_id.';limit:10;cache_name:default;cache_time:default;order:news_hits;sort:desc')" id="feifei">
      <li><a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_name'],$feifei['news_jumpurl'],1)}">{$feifei.news_name}</a></li></volist>
    </ol>
  </div>
</div>
</div>
<include file="Home:footer" />
</body>
</html>