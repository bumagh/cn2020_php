import{o as e,c as t,w as i,e as a,f as s,i as l,a4 as n,p as d,d as h,a5 as c,a as r,F as o,b as u,n as p,g as f,t as b,h as k,$ as g,I as m,W as y,r as C,Z as x}from"./index-be7fe8a3.js";import{_ as w}from"./uni-datetime-picker.650746f4.js";import{r as S}from"./uni-app.es.63fa007f.js";import{_}from"./_plugin-vue_export-helper.1b428a4d.js";const D=_({name:"TableCheckbox",emits:["checkboxSelected"],props:{indeterminate:{type:Boolean,default:!1},checked:{type:[Boolean,String],default:!1},disabled:{type:Boolean,default:!1},index:{type:Number,default:-1},cellData:{type:Object,default:()=>({})}},watch:{checked(e){"boolean"==typeof this.checked?this.isChecked=e:this.isChecked=!0},indeterminate(e){this.isIndeterminate=e}},data:()=>({isChecked:!1,isDisabled:!1,isIndeterminate:!1}),created(){"boolean"==typeof this.checked&&(this.isChecked=this.checked),this.isDisabled=this.disabled},methods:{selected(){this.isDisabled||(this.isIndeterminate=!1,this.isChecked=!this.isChecked,this.$emit("checkboxSelected",{checked:this.isChecked,data:this.cellData}))}}},[["render",function(n,d,h,c,r,o){const u=l;return e(),t(u,{class:"uni-table-checkbox",onClick:o.selected},{default:i((()=>[h.indeterminate?(e(),t(u,{key:1,class:"checkbox__inner checkbox--indeterminate"},{default:i((()=>[s(u,{class:"checkbox__inner-icon"})])),_:1})):(e(),t(u,{key:0,class:a(["checkbox__inner",{"is-checked":r.isChecked,"is-disable":r.isDisabled}])},{default:i((()=>[s(u,{class:"checkbox__inner-icon"})])),_:1},8,["class"]))])),_:1},8,["onClick"])}],["__scopeId","data-v-a8c44071"]]),T={reset:"重置",search:"搜索",submit:"确定",filter:"筛选",gt:"大于等于",lt:"小于等于",date:"日期范围"},v="select",V="search",$="range",R="date",I="timestamp";const N=_({name:"uniTh",options:{virtualHost:!0},components:{dropdown:_({name:"FilterDropdown",emits:["change"],components:{checkBox:D},options:{virtualHost:!0},props:{filterType:{type:String,default:v},filterData:{type:Array,default:()=>[]},mode:{type:String,default:"default"},map:{type:Object,default:()=>({text:"text",value:"value"})}},computed:{canReset(){return this.isSearch?this.filterValue.length>0:this.isSelect?this.checkedValues.length>0:this.isRange?this.gtValue.length>0&&this.ltValue.length>0:!!this.isDate&&this.dateSelect.length>0},isSelect(){return this.filterType===v},isSearch(){return this.filterType===V},isRange(){return this.filterType===$},isDate(){return this.filterType===R||this.filterType===I}},watch:{filterData(e){this._copyFilters()},indeterminate(e){this.isIndeterminate=e}},data:()=>({resource:T,enabled:!0,isOpened:!1,dataList:[],filterValue:"",checkedValues:[],gtValue:"",ltValue:"",dateRange:[],dateSelect:[]}),created(){this._copyFilters()},methods:{_copyFilters(){let e=JSON.parse(JSON.stringify(this.filterData));for(let t=0;t<e.length;t++)void 0===e[t].checked&&(e[t].checked=!1);this.dataList=e},openPopup(){this.isOpened=!0,this.isDate&&this.$nextTick((()=>{this.dateRange.length||this.resetDate(),this.$refs.datetimepicker.show()}))},closePopup(){this.isOpened=!1},handleClose(e){this.closePopup()},resetDate(){let e=(new Date).toISOString().split("T")[0];this.dateRange=[e+" 0:00:00",e+" 23:59:59"]},onDropdown(e){this.openPopup()},onItemClick(e,t){let i=this.dataList,a=i[t];void 0===a.checked?i[t].checked=!0:i[t].checked=!a.checked;let s=[];for(let l=0;l<i.length;l++){const e=i[l];e.checked&&s.push(e.value)}this.checkedValues=s},datetimechange(e){this.closePopup(),this.dateRange=e,this.dateSelect=e,this.$emit("change",{filterType:this.filterType,filter:e})},timepickerclose(e){this.closePopup()},handleSelectSubmit(){this.closePopup(),this.$emit("change",{filterType:this.filterType,filter:this.checkedValues})},handleSelectReset(){if(this.canReset){var e=this.dataList;for(let t=0;t<e.length;t++){let i=e[t];this.$set(i,"checked",!1)}this.checkedValues=[],this.handleSelectSubmit()}},handleSearchSubmit(){this.closePopup(),this.$emit("change",{filterType:this.filterType,filter:this.filterValue})},handleSearchReset(){this.canReset&&(this.filterValue="",this.handleSearchSubmit())},handleRangeSubmit(e){this.closePopup(),this.$emit("change",{filterType:this.filterType,filter:!0===e?[]:[parseInt(this.gtValue),parseInt(this.ltValue)]})},handleRangeReset(){this.canReset&&(this.gtValue="",this.ltValue="",this.handleRangeSubmit(!0))}}},[["render",function(y,C,x,_,D,T){const v=l,V=n("check-box"),$=k,R=g,I=m,N=S(d("uni-datetime-picker"),w);return e(),t(v,{class:"uni-filter-dropdown"},{default:i((()=>[s(v,{class:"dropdown-btn",onClick:T.onDropdown},{default:i((()=>[T.isSelect||T.isRange?(e(),t(v,{key:0,class:a(["icon-select",{active:T.canReset}])},null,8,["class"])):h("",!0),T.isSearch?(e(),t(v,{key:1,class:a(["icon-search",{active:T.canReset}])},{default:i((()=>[s(v,{class:"icon-search-0"}),s(v,{class:"icon-search-1"})])),_:1},8,["class"])):h("",!0),T.isDate?(e(),t(v,{key:2,class:a(["icon-calendar",{active:T.canReset}])},{default:i((()=>[s(v,{class:"icon-calendar-0"}),s(v,{class:"icon-calendar-1"})])),_:1},8,["class"])):h("",!0)])),_:1},8,["onClick"]),D.isOpened?(e(),t(v,{key:0,class:"uni-dropdown-cover",onClick:T.handleClose},null,8,["onClick"])):h("",!0),D.isOpened?(e(),t(v,{key:1,class:"dropdown-popup dropdown-popup-right",onClick:C[3]||(C[3]=c((()=>{}),["stop"]))},{default:i((()=>[T.isSelect?(e(),t(v,{key:0,class:"list"},{default:i((()=>[(e(!0),r(o,null,u(D.dataList,((a,l)=>(e(),t(R,{class:"flex-r a-i-c list-item",key:l,onClick:e=>T.onItemClick(e,l)},{default:i((()=>[s(V,{class:"check",checked:a.checked},null,8,["checked"]),s(v,{class:"checklist-content"},{default:i((()=>[s($,{class:"checklist-text",style:p(a.styleIconText)},{default:i((()=>[f(b(a[x.map.text]),1)])),_:2},1032,["style"])])),_:2},1024)])),_:2},1032,["onClick"])))),128))])),_:1})):h("",!0),T.isSelect?(e(),t(v,{key:1,class:"flex-r opera-area"},{default:i((()=>[s(v,{class:a(["flex-f btn btn-default",{disable:!T.canReset}]),onClick:T.handleSelectReset},{default:i((()=>[f(b(D.resource.reset),1)])),_:1},8,["class","onClick"]),s(v,{class:"flex-f btn btn-submit",onClick:T.handleSelectSubmit},{default:i((()=>[f(b(D.resource.submit),1)])),_:1},8,["onClick"])])),_:1})):h("",!0),T.isSearch?(e(),t(v,{key:2,class:"search-area"},{default:i((()=>[s(I,{class:"search-input",modelValue:D.filterValue,"onUpdate:modelValue":C[0]||(C[0]=e=>D.filterValue=e)},null,8,["modelValue"])])),_:1})):h("",!0),T.isSearch?(e(),t(v,{key:3,class:"flex-r opera-area"},{default:i((()=>[s(v,{class:"flex-f btn btn-submit",onClick:T.handleSearchSubmit},{default:i((()=>[f(b(D.resource.search),1)])),_:1},8,["onClick"]),s(v,{class:a(["flex-f btn btn-default",{disable:!T.canReset}]),onClick:T.handleSearchReset},{default:i((()=>[f(b(D.resource.reset),1)])),_:1},8,["class","onClick"])])),_:1})):h("",!0),T.isRange?(e(),t(v,{key:4},{default:i((()=>[s(v,{class:"input-label"},{default:i((()=>[f(b(D.resource.gt),1)])),_:1}),s(I,{class:"input",modelValue:D.gtValue,"onUpdate:modelValue":C[1]||(C[1]=e=>D.gtValue=e)},null,8,["modelValue"]),s(v,{class:"input-label"},{default:i((()=>[f(b(D.resource.lt),1)])),_:1}),s(I,{class:"input",modelValue:D.ltValue,"onUpdate:modelValue":C[2]||(C[2]=e=>D.ltValue=e)},null,8,["modelValue"])])),_:1})):h("",!0),T.isRange?(e(),t(v,{key:5,class:"flex-r opera-area"},{default:i((()=>[s(v,{class:a(["flex-f btn btn-default",{disable:!T.canReset}]),onClick:T.handleRangeReset},{default:i((()=>[f(b(D.resource.reset),1)])),_:1},8,["class","onClick"]),s(v,{class:"flex-f btn btn-submit",onClick:T.handleRangeSubmit},{default:i((()=>[f(b(D.resource.submit),1)])),_:1},8,["onClick"])])),_:1})):h("",!0),T.isDate?(e(),t(v,{key:6},{default:i((()=>[s(N,{ref:"datetimepicker",value:D.dateRange,type:"datetimerange","return-type":"timestamp",onChange:T.datetimechange,onMaskClick:T.timepickerclose},{default:i((()=>[s(v)])),_:1},8,["value","onChange","onMaskClick"])])),_:1})):h("",!0)])),_:1})):h("",!0)])),_:1})}],["__scopeId","data-v-3ed2b14f"]])},emits:["sort-change","filter-change"],props:{width:{type:[String,Number],default:""},align:{type:String,default:"left"},rowspan:{type:[Number,String],default:1},colspan:{type:[Number,String],default:1},sortable:{type:Boolean,default:!1},filterType:{type:String,default:""},filterData:{type:Array,default:()=>[]}},data:()=>({border:!1,ascending:!1,descending:!1}),computed:{customWidth(){if("number"==typeof this.width)return this.width;if("string"==typeof this.width){let e=new RegExp(/^[1-9][0-9]*px$/g),t=new RegExp(/^[1-9][0-9]*rpx$/g),i=new RegExp(/^[1-9][0-9]*$/g);if(null!==this.width.match(e))return this.width.replace("px","");if(null!==this.width.match(t)){let e=Number(this.width.replace("rpx","")),t=y().screenWidth/750;return Math.round(e*t)}return null!==this.width.match(i)?this.width:""}return""},contentAlign(){let e="left";switch(this.align){case"left":e="flex-start";break;case"center":e="center";break;case"right":e="flex-end"}return e}},created(){this.root=this.getTable("uniTable"),this.rootTr=this.getTable("uniTr"),this.rootTr.minWidthUpdate(this.customWidth?this.customWidth:140),this.border=this.root.border,this.root.thChildren.push(this)},methods:{sort(){if(this.sortable)return this.clearOther(),this.ascending||this.descending?this.ascending&&!this.descending?(this.ascending=!1,this.descending=!0,void this.$emit("sort-change",{order:"descending"})):void(!this.ascending&&this.descending&&(this.ascending=!1,this.descending=!1,this.$emit("sort-change",{order:null}))):(this.ascending=!0,void this.$emit("sort-change",{order:"ascending"}))},ascendingFn(){this.clearOther(),this.ascending=!this.ascending,this.descending=!1,this.$emit("sort-change",{order:this.ascending?"ascending":null})},descendingFn(){this.clearOther(),this.descending=!this.descending,this.ascending=!1,this.$emit("sort-change",{order:this.descending?"descending":null})},clearOther(){this.root.thChildren.map((e=>(e!==this&&(e.ascending=!1,e.descending=!1),e)))},ondropdown(e){this.$emit("filter-change",e)},getTable(e){let t=this.$parent,i=t.$options.name;for(;i!==e;){if(t=t.$parent,!t)return!1;i=t.$options.name}return t}}},[["render",function(d,o,u,f,b,g){const m=k,y=l,x=n("dropdown");return e(),r("th",{rowspan:u.rowspan,colspan:u.colspan,class:a(["uni-table-th",{"table--border":b.border}]),style:p({width:g.customWidth+"px","text-align":u.align})},[s(y,{class:"uni-table-th-row"},{default:i((()=>[s(y,{class:"uni-table-th-content",style:p({"justify-content":g.contentAlign}),onClick:g.sort},{default:i((()=>[C(d.$slots,"default",{},void 0,!0),u.sortable?(e(),t(y,{key:0,class:"arrow-box"},{default:i((()=>[s(m,{class:a(["arrow up",{active:b.ascending}]),onClick:c(g.ascendingFn,["stop"])},null,8,["class","onClick"]),s(m,{class:a(["arrow down",{active:b.descending}]),onClick:c(g.descendingFn,["stop"])},null,8,["class","onClick"])])),_:1})):h("",!0)])),_:3},8,["style","onClick"]),u.filterType||u.filterData.length?(e(),t(x,{key:0,filterData:u.filterData,filterType:u.filterType,onChange:g.ondropdown},null,8,["filterData","filterType","onChange"])):h("",!0)])),_:3})],14,["rowspan","colspan"])}],["__scopeId","data-v-e92a6103"]]);const O=_({name:"uniTr",components:{tableCheckbox:D},props:{disabled:{type:Boolean,default:!1},keyValue:{type:[String,Number],default:""}},options:{virtualHost:!0},data:()=>({value:!1,border:!1,selection:!1,widthThArr:[],ishead:!0,checked:!1,indeterminate:!1}),created(){this.root=this.getTable(),this.head=this.getTable("uniThead"),this.head&&(this.ishead=!1,this.head.init(this)),this.border=this.root.border,this.selection=this.root.type,this.root.trChildren.push(this);const e=this.root.data.find((e=>e[this.root.rowKey]===this.keyValue));e&&(this.rowData=e),this.root.isNodata()},mounted(){if(this.widthThArr.length>0){const e="selection"===this.selection?50:0;this.root.minWidth=this.widthThArr.reduce(((e,t)=>Number(e)+Number(t)))+e}},unmounted(){const e=this.root.trChildren.findIndex((e=>e===this));this.root.trChildren.splice(e,1),this.root.isNodata()},methods:{minWidthUpdate(e){this.widthThArr.push(e)},checkboxSelected(e){let t=this.root.data.find((e=>e[this.root.rowKey]===this.keyValue));this.checked=e.checked,this.root.check(t||this,e.checked,t?this.keyValue:null)},change(e){this.root.trChildren.forEach((t=>{t===this&&this.root.check(this,e.detail.value.length>0)}))},getTable(e="uniTable"){let t=this.$parent,i=t.$options.name;for(;i!==e;){if(t=t.$parent,!t)return!1;i=t.$options.name}return t}}},[["render",function(t,i,l,d,c,o){const u=n("table-checkbox");return e(),r("tr",{class:"uni-table-tr"},["selection"===c.selection&&c.ishead?(e(),r("th",{key:0,class:a(["checkbox",{"tr-table--border":c.border}])},[s(u,{checked:c.checked,indeterminate:c.indeterminate,disabled:l.disabled,onCheckboxSelected:o.checkboxSelected},null,8,["checked","indeterminate","disabled","onCheckboxSelected"])],2)):h("",!0),C(t.$slots,"default",{},void 0,!0)])}],["__scopeId","data-v-8aa202e3"]]);const A=_({name:"uniTd",options:{virtualHost:!0},props:{width:{type:[String,Number],default:""},align:{type:String,default:"left"},rowspan:{type:[Number,String],default:1},colspan:{type:[Number,String],default:1}},data:()=>({border:!1}),created(){this.root=this.getTable(),this.border=this.root.border},methods:{getTable(){let e=this.$parent,t=e.$options.name;for(;"uniTable"!==t;){if(e=e.$parent,!e)return!1;t=e.$options.name}return e}}},[["render",function(t,i,s,l,n,d){return e(),r("td",{class:a(["uni-table-td",{"table--border":n.border}]),rowspan:s.rowspan,colspan:s.colspan,style:p({width:s.width+"px","text-align":s.align})},[C(t.$slots,"default",{},void 0,!0)],14,["rowspan","colspan"])}],["__scopeId","data-v-f1e869b7"]]);const W=_({name:"uniTable",options:{virtualHost:!0},emits:["selection-change"],props:{data:{type:Array,default:()=>[]},border:{type:Boolean,default:!1},stripe:{type:Boolean,default:!1},type:{type:String,default:""},emptyText:{type:String,default:"没有更多数据"},loading:{type:Boolean,default:!1},rowKey:{type:String,default:""}},data:()=>({noData:!0,minWidth:0,multiTableHeads:[]}),watch:{loading(e){},data(e){this.theadChildren,this.theadChildren&&this.theadChildren.rowspan,this.noData=!1}},created(){this.trChildren=[],this.thChildren=[],this.theadChildren=null,this.backData=[],this.backIndexData=[]},methods:{isNodata(){this.theadChildren;let e=1;this.theadChildren&&(e=this.theadChildren.rowspan),this.noData=this.trChildren.length-e<=0},selectionAll(){let e=1,t=this.theadChildren;this.theadChildren?e=t.rowspan-1:t=this.trChildren[0];let i=this.data&&this.data.length>0;t.checked=!0,t.indeterminate=!1,this.trChildren.forEach(((t,a)=>{if(!t.disabled){if(t.checked=!0,i&&t.keyValue){const e=this.data.find((e=>e[this.rowKey]===t.keyValue));this.backData.find((t=>t[this.rowKey]===e[this.rowKey]))||this.backData.push(e)}a>e-1&&-1===this.backIndexData.indexOf(a-e)&&this.backIndexData.push(a-e)}})),this.$emit("selection-change",{detail:{value:this.backData,index:this.backIndexData}})},toggleRowSelection(e,t){e=[].concat(e),this.trChildren.forEach(((i,a)=>{const s=e.findIndex((e=>"number"==typeof e?e===a-1:e[this.rowKey]===i.keyValue));let l=i.checked;-1!==s&&(i.checked="boolean"==typeof t?t:!i.checked,l!==i.checked&&this.check(i.rowData||i,i.checked,i.rowData?i.keyValue:null,!0))})),this.$emit("selection-change",{detail:{value:this.backData,index:this.backIndexData}})},clearSelection(){let e=this.theadChildren;this.theadChildren||(e=this.trChildren[0]),e.checked=!1,e.indeterminate=!1,this.trChildren.forEach((e=>{e.checked=!1})),this.backData=[],this.backIndexData=[],this.$emit("selection-change",{detail:{value:[],index:[]}})},toggleAllSelection(){let e=[],t=1,i=this.theadChildren;this.theadChildren?t=i.rowspan-1:i=this.trChildren[0],this.trChildren.forEach(((i,a)=>{i.disabled||a>t-1&&e.push(a-t)})),this.toggleRowSelection(e)},check(e,t,i,a){let s=this.theadChildren;this.theadChildren||(s=this.trChildren[0]);let l=this.trChildren.findIndex(((t,i)=>e===t));if(l<0&&(l=this.data.findIndex((e=>e[this.rowKey]===i))+1),this.trChildren.filter((e=>!e.disabled&&e.keyValue)).length,0===l)return void(t?this.selectionAll():this.clearSelection());if(t)i&&this.backData.push(e),this.backIndexData.push(l-1);else{const e=this.backData.findIndex((e=>e[this.rowKey]===i)),t=this.backIndexData.findIndex((e=>e===l-1));i&&this.backData.splice(e,1),this.backIndexData.splice(t,1)}this.trChildren.find(((e,t)=>t>0&&!e.checked&&!e.disabled))?(s.indeterminate=!0,s.checked=!1):(s.indeterminate=!1,s.checked=!0),0===this.backIndexData.length&&(s.indeterminate=!1),a||this.$emit("selection-change",{detail:{value:this.backData,index:this.backIndexData}})}}},[["render",function(n,d,c,r,o,u){const k=l;return e(),t(k,{class:a(["uni-table-scroll",{"table--border":c.border,"border-none":!o.noData}])},{default:i((()=>[x("table",{class:a(["uni-table",{"table--stripe":c.stripe}]),border:"0",cellpadding:"0",cellspacing:"0",style:p({"min-width":o.minWidth+"px"})},[C(n.$slots,"default",{},void 0,!0),o.noData?(e(),t(k,{key:0,class:"uni-table-loading"},{default:i((()=>[s(k,{class:a(["uni-table-text",{"empty-border":c.border}])},{default:i((()=>[f(b(c.emptyText),1)])),_:1},8,["class"])])),_:1})):h("",!0),c.loading?(e(),t(k,{key:1,class:a(["uni-table-mask",{"empty-border":c.border}])},{default:i((()=>[x("div",{class:"uni-table--loader"})])),_:1},8,["class"])):h("",!0)],6)])),_:3},8,["class"])}],["__scopeId","data-v-c5373dca"]]);export{N as _,O as a,A as b,W as c};
