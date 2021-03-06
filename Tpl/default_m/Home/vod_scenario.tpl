<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>{$list_name}《{$vod_name}》Diversity plot introduction－{$site_name}</title>
<meta name="keywords" content="{$vod_name}Diversity plot,{$vod_name}Watch online,{$vod_name}Synopsis">
<meta name="description" content="{$list_name}{$vod_name}Diversity plot,{$vod_name}Brief introduction:{$vod_content|strip_tags|msubstr=0,100}">
</head>
<body>
<include file="Home:header" />
<div class="container vod-detail ff-bg">
<div class="row">
	<div class="col-xs-12 ff-col">
  	<div class="page-header">
      <h4><span class="glyphicon glyphicon-film ff-text"></span> <a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$list_name}</a> <small>{$vod_name} <include file="Home:block_vod_continu" /></small></h4>
    </div>
    <ul class="list-unstyled vod-infos">
    	<li class="col-xs-4">
      	<img class="img-responsive img-thumbnail ff-img vod-pic" data-original="{$vod_pic|ff_url_img=$vod_content}" alt="{$vod_name}Complete watch">
      </li>
      <li class="col-xs-8">
      	<h4><a href="{:ff_url_vod_read($list_id,$list_dir,$vod_id,$vod_ename,$vod_jumpurl)}" class="ff-text">{$vod_name}</a></h4>
      	<dl class="dl-horizontal">
          <dt>Starring</dt>
          <dd class="ff-text-hidden ff-link">{$vod_actor|ff_url_search}</dd>
          <dt>Types of:</dt>
          <dd class="ff-text-hidden"><a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$list_name}</a><include file="Home:block_vod_tags" /></dd>
          <dt>director:</dt>
          <dd class="ff-text-hidden ff-link">{$vod_director|ff_url_search='director'}</dd>
          <dt>area:</dt>
          <dd><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>urlencode($vod_area),'year'=>'','star'=>'','state'=>'','order'=>'hits'),true)}">{$vod_area|default='Not entered'}</a></dd>
          <dt>years:</dt>
          <dd><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>'','year'=>$vod_year,'star'=>'','state'=>'','order'=>'hits'),true)}">{$vod_year|default='2016'}</a></dd>
        </dl>
      </li>
    </ul>
    <div class="clearfix ff-clearfix"></div>
    <notempty name="vod_scenario.info">
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
      <h4><span class="glyphicon glyphicon-th-list ff-text"></span> {$vod_name}Diversity plot</h4>
    </div>   
    <dl class="vod_scenario">
    	<volist name="vod_scenario.info" id="feifei">
      <dt id="vod_scenario_title_{$i}" class="vod_scenario_title">
      	<a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,1,$i)}" class="ff-text">{$vod_name} First{$i}set</a>
      </dt>
      <dd id="vod_scenario_info_{$i}" class="vod_scenario_info">
      	{$feifei}<a href="{:ff_url('vod/scenario', array('id'=>$vod_id,pid=>$i), true)}" class="ff-text">Details...</a>
       </dd>
      </volist>
    </dl>
    </notempty>
  </div><!-- -->
</div>
</div>
<include file="Home:footer" />
</body>
</html>