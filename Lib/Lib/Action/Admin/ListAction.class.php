 <?php
class ListAction extends BaseAction{	
	// 显示分类
  public function show(){
		$params = array();
		$params['field'] = '*';
		$params['limit'] = false;
		$params['order'] = 'list_id asc,list_oid';
		$params['sort'] = 'asc';
		$infos = D("List")->ff_select_page($params);
		if($infos){
			$this->assign('listtree',$infos);
			$this->display('./Public/system/list_show.html');
		}else{
		  $this->assign("jumpUrl",'?s=Admin-List-Add');
			$this->success('No classification data Please add first!');		    
		}
  }
	
	// 添加编辑分类
  public function add(){
		$cid = intval($_GET['id']);
	  $rs = D("List");
		if ($cid) {
			$info = $rs->ff_find('*', array('list_id'=>array('eq',$cid)) );
			$info['tpltitle'] = 'edit';
		}else{
		  $info['list_id'] = 0;
		  $info['list_pid'] = intval($_GET['pid']);
			$info['list_sid'] = intval($_GET['sid']);
		  $info['list_oid'] = $rs->max('list_oid')+1;
			$info['list_status'] = 1;
			$info['tpltitle'] = 'Add to';
		}
		$this->assign($info);
		$this->display('./Public/system/list_add.html');
  }
	public function update(){
		$data = D('List')->ff_update($_POST);
		if(!$data['list_id']){
			$this->error(D('List')->getError());
		}
		$this->assign("jumpUrl",'?s=Admin-List-Show');
		$this->success('Congratulations, the operation is done!');
	}	
	// 批量更新数据
  public function updateall(){
		if(empty($_POST['ids'])){
			$this->error('Please select the section you want to modify!');
		}
		$rs = D("List");
		$array = $_POST;
		foreach($array['ids'] as $key=>$value){
		  $data['list_oid'] = intval($array['list_oid'][$value]);
			$data['list_name'] = $array['list_name'][$value];
			$data['list_skin'] = $array['list_skin'][$value];
			if(empty($array['list_dir'][$value])){
				$data['list_dir'] = ff_pinyin($array['list_name'][$value]);
			}else{
				$data['list_dir'] = $array['list_dir'][$value];
			}				
			$rs->where('list_id = '.intval($value))->save($data);
		}
		$this->redirect('Admin-List/Show');
  }
	// 隐藏与显示栏目
  public function status(){
		C('TOKEN_ON',false);
		$data = array();
		$data['list_id'] = intval($_GET['id']);
		$data['list_status'] = 1;
		if (intval($_GET['sid']) == 2) {
			$data['list_status'] = 0;
		}
		D('List')->data($data)->save();
		$this->redirect('Admin-List/Show');
  }
	// 删除数据
  public function del(){
		$rs = D("List");
		$where['list_id'] = $_GET['id'];
		if (!ff_list_isson($_GET['id'])) {
			$this->error("Please delete the sub-section below this category!");
		}
		$rs->where($where)->delete();
		$sid = ff_list_find($id,'list_sid');
		$this->deldata($sid,$id);
		$this->success('Successfully deleted this column category related to this category!');
  }
	//删除对应的数据
	public function deldata($sid,$cid){
		if ($sid == 1) {
			$rs = M("Vod");
			$rs->where('vod_cid = '.$cid)->delete();
		}elseif($sid == 2){
			$rs = M("News");
			$rs->where('news_cid = '.$cid)->delete();			
		}
	}
	// 批量删除数据
  public function delall(){
		if(empty($_POST['ids'])){
			$this->error('Please select the section you want to delete!');
		}	
		$list = D("List");
		$array = $_POST;
		foreach($array['ids'] as $value){
			$id = intval($value);
			$sid = ff_list_find($id,'list_sid');
			if (!ff_list_isson($id)) {
				$this->error("Please delete the sub-section below this category!");
			}			
		  $list->where('list_id = '.$id)->delete(); 
			$this->deldata($sid,$id);
		}
		$this->success('Batch delete column success!');
  }
	//
	public function extend(){
		$info = D("List")->ff_find('*', array('list_id'=>array('eq',intval($_GET['id']))) );
		if($info){
			$json = array();
			foreach($info["list_extend"] as $key=>$value){
				$options = '';
				foreach(explode(',',$value) as $option){
					$json[$key][] = $option;
				}
			}
			$this->ajaxReturn($json,"ok",1);
		}else{
			$this->ajaxReturn($json,"faild",0);
		}
		
	}
}
?>