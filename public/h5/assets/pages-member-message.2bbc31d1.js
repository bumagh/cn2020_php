import{B as e,E as t,y as a,j as s,l as i,o as l,c as o,w as c,i as n,f as m,a as g,b as r,F as u,p as d,g as f,t as p,h}from"./index-be7fe8a3.js";import{_}from"./uni-icons.43709c62.js";import{r as y}from"./uni-app.es.63fa007f.js";import{_ as b}from"./uni-list-chat.0ac62b4d.js";import{_ as k}from"./uni-list.d1919617.js";import{_ as j}from"./uni-pagination.b2603419.js";import{p as x}from"./util.ff018e21.js";import{_ as C}from"./_plugin-vue_export-helper.1b428a4d.js";const M=C({data:()=>({message:{data:[],count:0,page:0,limit:10}}),mounted(){},onLoad(){this.login=e("myAuth")||{},Object.keys(this.login).length<1&&t({url:"/pages/member/index"})},onShow(){this.getMessage()},methods:{change(e){this.message.page=e.current,this.getMessage()},clickMessageItem(e,t){let l=this;a({title:"0"==e.fromuid?"系统消息：":"用户消息："+e.tag,content:e.content,confirmText:"知道了",cancelText:"删除",cancelColor:"#ff0a00",success:function(a){let o={};o.id=e.id,a.confirm?x(s().globalData.eyUrl+"message/setread",o).then((e=>{let a=e.data;"1"==a.code?l.message.data[t].status=0:i({icon:"none",title:a.msg})})):a.cancel&&x(s().globalData.eyUrl+"message/del",o).then((e=>{let a=e.data;"1"==a.code?l.message.data.splice(t,1):i({icon:"none",title:a.msg})}))}})},getMessage(){let e=this,t={};t.page=this.message.page,t.limit=this.message.limit,t.count=this.message.count,x(s().globalData.eyUrl+"message/getmine",t).then((t=>{let a=t.data;"1"==a.code?(e.message.data=a.data,a.count&&(e.message.count=a.count),a.page&&(e.message.page=a.page),a.limit&&(e.message.limit=a.limit)):i({icon:"none",title:a.msg})}))},setRead(){},setDel(){}}},[["render",function(e,t,a,s,i,x){const C=h,M=y(d("uni-icons"),_),v=n,z=y(d("uni-list-chat"),b),D=y(d("uni-list"),k),I=y(d("uni-pagination"),j);return l(),o(v,{class:"container"},{default:c((()=>[m(D,{border:!0},{default:c((()=>[(l(!0),g(u,null,r(i.message.data,((e,t)=>(l(),o(v,{key:t},{default:c((()=>[0==e.fromuid?(l(),o(z,{key:0,clickable:"",onClick:a=>x.clickMessageItem(e,t),title:e.tag,avatar:"/static/tipsystem.png",note:e.content},{default:c((()=>[m(v,{class:"chat-custom-right"},{default:c((()=>[m(C,{class:"chat-custom-text"},{default:c((()=>[f(p(e.created_at),1)])),_:2},1024),1==e.status?(l(),o(M,{key:0,type:"smallcircle-filled",color:"#f90000",size:"14"})):(l(),o(M,{key:1,type:"smallcircle-filled",color:"#bfbfbf",size:"14"}))])),_:2},1024)])),_:2},1032,["onClick","title","note"])):(l(),o(z,{key:1,clickable:"",onClick:a=>x.clickMessageItem(e,t),title:e.tag,avatar:"/static/tipmember.png",note:e.content},{default:c((()=>[m(v,{class:"chat-custom-right"},{default:c((()=>[m(C,{class:"chat-custom-text"},{default:c((()=>[f(p(e.created_at),1)])),_:2},1024),1==e.status?(l(),o(M,{key:0,type:"smallcircle-filled",color:"#f90000",size:"14"})):(l(),o(M,{key:1,type:"smallcircle-filled",color:"#bfbfbf",size:"14"}))])),_:2},1024)])),_:2},1032,["onClick","title","note"]))])),_:2},1024)))),128))])),_:1}),m(I,{onChange:x.change,total:i.message.count,pageSize:10,title:"标题文字"},null,8,["onChange","total"])])),_:1})}],["__scopeId","data-v-4b88d75a"]]);export{M as default};
