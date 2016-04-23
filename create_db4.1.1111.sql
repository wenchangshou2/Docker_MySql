
DROP TABLE IF EXISTS sysuser;
create table sysuser
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	name VARCHAR(128) CHARACTER SET utf8 not null,				-- 名称
	desp VARCHAR(128),		  						-- 描述
	pwd VARCHAR(128) not null,						-- 密码
	type int(12) not null,						-- 类型，0-管理员 1-操作员 2-浏览者
	logintimes int(11),							-- 登陆次数
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS farminfo;
create table farminfo
(
	id int(11)unsigned NOT NULL AUTO_INCREMENT,
	name VARCHAR(128) CHARACTER SET utf8 not null,	-- 名称
	corporation VARCHAR(128) CHARACTER SET utf8,	-- 发电集团
	location VARCHAR(128) CHARACTER SET utf8,		-- 建设地点
	gpsxy VARCHAR(128) CHARACTER SET utf8,			-- 坐标(经度、纬度)
	area float(18,6),								-- 占地面积(平方米)
	allcapacity float(18,6) not null,				-- 总装机容量(MW)
	runcapacity float(18,6) not null,				-- 投运装机容量(MW)
	landform VARCHAR(128) CHARACTER SET utf8,		-- 地形
	granulation VARCHAR(128) CHARACTER SET utf8,	-- 粗糙度
	powerdensity float(18,6),						-- 功率密度(W/㎡)
	iltsname  VARCHAR(128) CHARACTER SET utf8,		-- 上网变电站名称
	version VARCHAR(64),							-- 版本号
	-- -接口写入数据
	p_id int(11) not null unique,				-- 升压站高压侧总有功tagID(MW) 页面显示实时有功字段
	q_id int(11) not null unique,				-- 升压站高压侧总无功tagID (MVar)
	busrtv_id int(11) not null unique,			-- 母线电压实时值(母线电压实时值)(KV)
	busri_id  int(11) not null unique,			-- 母线电流实时值(高压侧电流)(A)
	fusev_id int(11) not null unique,			-- 场用电压实时值(V)
	fchildv_id int(11) not null unique,			-- 35KV电压实时值(KV)
	farmsump_id int(11) not null unique,		-- 电场逆变器(风机)总有功之和tagID(MV)
	farmsumq_id int(11) not null unique,		-- 电场逆变器(风机)总无功之和tagID(MVar)
	wsavg_id int(11) not null unique,			-- 平均风速tagID(m/s)
	wvavg_id int(11) not null unique,			-- 平均风向tagID(度)
	irradiance_id int(11) not null unique,		-- 辐照度(W/㎡)
	tp_id int(11) not null unique,				-- 理论有功ID(MW)
	rcap_id int(11) not null unique,			-- 实际开机容量ID(MW)
	runnum_id int(11) not null unique,			-- 逆变器(风机)运行台数ID
	rpower_id int(11) not null unique,			-- 日累计电量ID(KWH)
	tpower_id int(11) not null unique,			-- 日理论电量ID (KWH)
	mcstie_id int(11) not null unique,			-- 电场主变分接头位置(0-default,1-分接头档位I、2-分接头档位II、3-分接头档位III、4-分接头档位IV、5-分接头档位IIV)
	--
	-- added by zsh 2013-09-05 for 事故总信号
	fault_id int(11) not null unique,     -- 事故总信号(0-default, 0-正常, 1-总事故信号报警)
	-- added by zsh 2013-09-05 for 事故总信号
	-- added by dongya.hao 2015-07-02 start
	qsuccessTime_id int(16) not null unique,     -- 目标电压调解成功花费时间
	psuccessTime_id int(16) not null unique,     -- 目标有功调解成功花费时间
	-- added by dongya.hao 2015-07-02 end
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS agcsysinfo;
create table agcsysinfo
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	-- 用户配置
	conintertime_id	int(11) not null unique,		-- AGC全场控制间隔时间ID(default 30s 距离上次调控的最小时间)(s)
	gplanouttime_id int(11) not null unique,		-- AGC调度命令有效时间(默认600秒)(s)		 3.1改为遥测上送时间
	phlimit_id int(11) not null unique,			-- 全厂出力上限(由系统接口产生，根据实时开机容量计算而来)(MW)
	pllimit_id int(11) not null unique,			-- 全厂出力下限(由系统接口产生)(MW)
	-- //
	-- delete zhouxuewu 20131104
	-- ephlimit_id int(11) not null unique,			--全厂经济运行出力上限(MW)
	-- epllimit_id int(11) not null unique,			--全厂经济运行出力下限(MW)
	-- //
	pdeadarea_id int(11) not null unique,			-- 全厂出力控制死区(界面系统设置)(MW)
	fprocmax_id int(11) not null unique,			-- 全场出力最大功率变化率(容量%/次)
	fpcrocmax_id int(11) not null unique,			-- 全场出力持续最大功率变化率(%额定容量/min)
	-- //
	-- delete zhouxuewu 20131104
	-- fupv_id int(11) not null unique,			--全厂升出力响应速度(MW/min)
	-- fdpv_id int(11) not null unique,			--全厂降出力响应速度(MW/min)
	-- //
	rtcp_id int(11) not null unique,			-- AGC当前分配策略(1-按裕度分配)
	-- //
	-- added by xuewu.zhou 2014-04-22 for 内部策略配置项 start
	micadjratio_id int(11) not null unique,							-- AGC微调比例										(default-0)
	micdeadarea_id int(11) not null unique,							-- AGC微调死区值									(default-0)(MW)
	timegap_id int(11) not null unique,									-- AGC调节单台逆变器所需时间间隔	(default-0)(s)
	isagcreset_id int(11) not null unique,								-- AGC若无调度命令是否恢复逆变器满发标志	(default-0)
	plantimeout_id int(11) not null unique,							-- AGC无调度命令至AGC恢复逆变器满发时间 	(default-7200)(s)
	timeoutratio_id int(11) not null unique,							-- AGC恢复满发比率												(default-100)
	-- added by xuewu.zhou 2014-04-22 for 内部策略配置项 end
	-- //
	-- added by zuewu.zhou 2014-04-23 for 调度要求命令有限时间 start
	alivetime_id int(11) not null unique,                -- AGC调度要求命令有限时间
	-- added by xuewu.zhou 2014-04-24 for 调度要求命令有限时间 end
	-- //
	-- 系统数据，不需配置
	agcstart_id int(11) not null unique, 			-- AGC投入退出开关ID(default 0 1-投入，2-退出)
	agcstatus_id int(11) not null unique,			-- AGC运行状态(default 0、1-运行，2-退出)
	agccontrmod_id int(11) not null unique,		-- AGC控制模式(default 0、1-自动(通道)，2-手动(界面)，3-计划))
	agcmodstatus_id int(11) not null unique,		-- AGC控制模式状态(default 1、1-自动(通道)，2-手动(界面)，3-计划)  ///
	runstatus_id int(11) not null unique,			-- AGC系统运行状态(default 0、1-正常，2-故障(维修，网络中断)，3-挂起(数据异常))
	targetp_id int(11) not null unique,			-- AGC全厂目标出力(MW)
	rttargetp_id int(11) not null unique,		-- AGC实时命令目标值(调度命令)(MW)
	plantargetp_id int(11) not null unique,		-- AGC计划曲线目标值(计划曲线)(MW)
	mantargetp_id int(11) not null unique,		-- AGC手动目标值(手动设置)(MW)
	ctargetp_id int(11) not null unique,			-- AGC策略下发目标值(MW)
	unableadd_id int(11) not null unique,	-- AGC增闭锁(0-default, 1-增闭锁，2-增允许)
	unablesub_id int(11) not null unique,	-- AGC减闭锁(0-default, 1-减闭锁，2-减允许)
	-- //
	-- added by zsh 2013-09-04 for 闭锁信号 start
    unablecom_id int(11) not null unique,		-- AGC通信闭锁(0-default,，1-通信闭锁,2-正常)
	unableagc_id int(11) not null unique,		-- AGC系统故障闭锁(0-default，1-AGC系统故障闭锁,2-正常)由守护服务程序更新
	unablesys_id int(11) not null unique,			-- AGC系统事故总信号(0-default，1-事故总信号闭锁,2-正常)由接口更新事故总信号状态，AGC系统置闭锁。）
	-- added by zsh 2013-09-04 for 闭锁信号 end
	-- //
	-- added by zsh 2013-10-25 for 开环闭环运行 start
	loopaction_id int(11) not null unique, 			-- AGC开环运行、闭环运行命令(default 1 1-闭环，2-开环)
	loopstatus_id int(11) not null unique,			-- AGC开环运行、闭环运行状态(default 1、1-闭环，2-开环)
    strategy_id int(16) not null unique,			-- 策略选择
    offset_id int(16) not null unique,				-- 有功目标值偏移量(取值范围：-5~5)
    fulltargetp_id int(16) not null unique,			-- 满发
	-- sadded by zsh 2013-10-25 for 开环闭环运行 end
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS avcsysinfo;
create table avcsysinfo
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	-- AVC用户常用控制项目
	start_id int(11) not null unique, 		-- AVC投入退出开关ID(default 0-初始值，1-投入，2-退出, 3-强制退出)
	contrmod_id int(11) not null unique,		-- AGC控制模式(default 0, 1-自动(通道)，2-手动(界面)，3-计划)
	assmethod_id int(11) not null unique,	-- 无功分配方法(default 0, 1-等无功)
	-- 系统状态
	status_id int(11) not null unique,		-- AVC运行状态(default 0、 1-运行、2-退出
	modstatus_id int(11) not null unique,	-- AVC控制模式状态(default 1, 1-自动(通道)，2-手动(界面)，3-计划)  ///
	cmdtargetv_id int(11) not null unique,	-- AVC命令目标值(母线电压调节值)(KV)
	rttargetv_id int(11) not null unique,	-- AVC实时命令目标值(调度命令)(KV)
	plantargetv_id int(11) not null unique,	-- AVC计划曲线目标值(计划曲线)(KV)
	mantargetv_id int(11) not null unique,	-- AVC手动目标值(手动设置)(KV)
	bustargetv_id int(11) not null unique,	-- 母线电压目标值(策略下发母线电压目标值(计算产生))(KV)
	targetq_id int(11) not null unique,		-- 目标控制总无功(全场总无功用母线电压计算产生)(MVar)
	farmsumq_id int(11) not null unique,		-- 可调电场总无功(计算产生)(MVar)
	pf_id int(11) not null unique,		-- 功率因数(计算产生)
	-- lo_id int(11) not null unique,		-- 偏移系数(计算产生)
	sysimp_id int(11) not null unique,		-- 系统阻抗(计算产生)(KΩ)
	runstatus_id int(11) not null unique,	-- AVC系统运行状态(default 0, 1-正常，2-故障(维修，网络中断)，3-挂起(数据异常))
	unableadd_id int(11) not null unique,	-- AVC增磁闭锁(0-default, 1-增磁闭锁，2-增磁允许)
	unablesub_id int(11) not null unique,	-- AVC减磁闭锁(0-default, 1-减磁闭锁，2-减磁允许)
	-- //
	-- added by zsh 2013-09-04 for 闭锁信号 start
	unablecom_id int(11) not null unique,		-- AVC通信闭锁(0-default,1-通信闭锁，2-正常)
	unableavc_id int(11) not null unique,		-- AVC系统故障闭锁(0-default,1-AVC系统故障闭锁，2-正常)由守护服务程序更新
	unablesys_id int(11) not null unique,		-- AVC系统事故总信号闭锁(0-default,1-事故总信号闭锁，2-正常)由接口更新事故总信号状态，AVC系统置闭锁。）
	-- added by zsh 2013-09-04 for 闭锁信号 end
	-- //
	-- added by zsh 2013-10-25 for 开环闭环运行 start
	loopaction_id int(11) not null unique, 			-- AVC开环运行、闭环运行命令(default 1 1-闭环，2-开环)
	loopstatus_id int(11) not null unique,			-- AVC开环运行、闭环运行状态(default 1、1-闭环，2-开环)
	-- added by zsh 2013-10-25 for 开环闭环运行 end
	-- //
	-- added by zsh 2014-03-24 start for AVC实时可调容量
	qhcap_id int(11) not null unique,		-- -无功向上可调容量(MVar)
	qlcap_id int(11) not null unique,		-- -无功向下可调容量(MVar)
	-- added by zsh 2014-03-24 end for 	AVC实时可可调容量
	-- //
	-- added by zsh 2014-03-24 start for AVC是否需要调节分接头状态标识
	-- badjust_status_id int(11) not null unique,		--分接头是否需要调节(0-default, 0-不需要调节，1-需要调节)
	-- added by zsh 2014-03-24 end for 	AVC是否需要调节分接头状态标识
	-- AVC参数项
	deadareav_id int(11) not null unique,	-- 目标电压死区(KV)
	deadareaf_id int(11) not null unique,	-- 目标功率因数死区(KV)
	adjmaxarea_id int(11) not null unique,	-- 调节偏差范围(KV)
	standardv_id int(11) not null unique,	-- 标准电压(KV)
	sysimpmax_id int(11) not null unique,	-- 系统阻抗上限(KΩ)
	sysimpmin_id int(11) not null unique,	-- 系统阻抗下限(KΩ)
	-- minev_id int(11) not null unique,		-- 电压波动最小值(KV)
	bushlimitv_id int(11) not null unique,	-- 母线电压上限(KV)
	busllimitv_id int(11) not null unique,	-- 母线电压下限(KV)
	-- abushlimitv_id int(11) not null unique, -- 母线电压上限增量(KV)
	-- abusllimitv_id int(11) not null unique,  -- 母线电压下限增量(KV)
	farmvhlimit_id int(11) not null unique,	-- 场用电压上限(KV)
	farmvllimit_id int(11) not null unique,	-- 场用电压下限(KV)
	deadareaq_id int(11) not null unique,	-- 目标无功死区(MVar)
	buslhlimitq_id int(11) not null unique,	-- 全场无功上限(MVar)
	busllimitq_id int(11) not null unique,	-- 全场无功下限(MVar)
	-- abuslhlimitq_id int(11) not null unique,	-- 全场无功上限增量(MVar)
	-- abusllimitq_id int(11) not null unique,	-- 全场无功下限增量	(MVar)
	fvmax_id int(11) not null unique,		-- 全场电压持续最大功率变化率(1KV/min)
	conintertime_id	int(11) not null unique,	-- 全场控制间隔时间ID(default 30s、距离上次调控的最小时间)(s)
	gplanouttime_id int(11) not null unique,	-- AVC调度命令有效时间(默认600秒)(s) 3.1改为遥测上送时间
	-- //
	-- added by zsh 2014-03-24 start for AVC调节优先级
	priority_id int(11) not null unique,		-- -AVC调节优先级（1-default, 1-优先调节逆变器无功,2-优先调节SVG无功。主变分接头调节优先级最低）
	-- added by zsh 2014-03-24 end for 	AVC调节优先级
	-- //
	-- added by zsh 2014-03-25 start for AVC是否允许调节SVG无功
	asvgq_id int(11) not null unique,		-- -AVC是否调节SVG无功（0-default, 0-不允许调节，1-允许调节）
	-- added by zsh 2014-03-25 end for 	AVC是否允许调节SVG无功
	-- //
	-- added by zsh 2014-03-25 start for AVC是否允许调节逆变器无功
	ainverterq_id int(11) not null unique,		-- -AVC是否允许调节逆变器无功（0-default, 0-不允许调节，1-允许调节）
	-- added by zsh 2014-03-25 end for 	AVC是否允许调节逆变器无功
	-- //
	-- added by xuewu.zhou 2014-04-23 start for AVC配置项
	timegap_id int(11) not null unique,                -- xml文件中命令发送时间间隔
	alivetime_id int(11) not null unique,				-- AVC调度要求命令有限时间
    strategy_id int(16) not null unique,				-- 策略选择
    offset_id int(16) not null unique,	
    fulltargetp_id int(16) not null unique,
	svgcircsend_id int(16) not null unique,					-- 是否循环发送SVG命令	(default-0 否:0 是:1)
	btiectlmode_id int(16) not null unique,						-- 分接头调节是方式	(default-0 命令直接调节:0 产生警告框:1)
	-- added by xuewu.zhou 2014-04-23 end for 	AVC配置项
	-- added by xuewu.zhou 2015-07-02 start
	contdotmod_id int(16) not null unique,			-- 并网点控制模式(default 1-初始值，1 电压模式，2 无功模式，3 功率因数模式)
	dotmodstatus_id int(16) not null unique,		-- 并网点模式状态(default 1-初始值，1 电压模式，2 无功模式，3 功率因数模式)
	itcmdmod_id int(16) not null unique,			-- 逆变器命令模式(default 2-初始值，1 电压模式，2 无功模式，3 功率因数模式)
	itcmdstatus_id int(16) not null unique,		    -- 逆变器命令模式(default 2-初始值，1 电压模式，2 无功模式，3 功率因数模式)
	-- added by xuewu.zhou 2015-07-02 end
	-- added by dongya.hao 2015-07-02 start
	busrtvUpdateState_id int(16) not null unique,     -- 母线电压状态（default 0-初始值，1-不正常，2-正常）
	-- added by dongya.hao 2015-07-02 end
	PRIMARY KEY (`id`)

)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS svginfo;
create table svginfo
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,		-- svgID
	svgname VARCHAR(64)  CHARACTER SET utf8 not null,		-- svg名称
	-- 状态量
	run_id int(11) not null unique,		-- 运行状态(1、正常 2、异常)
	error_id int(11) not null unique,	       	-- 故障状态
	ready_id int(11) not null unique,		-- 就绪状态
	breakersta_id int(11) not null unique,		-- 断路器状态
	hdiscsta_id int(11) not null unique,		-- 上级接地刀闸状态
	hisosta_id int(11) not null unique,		-- 上级隔离开关状态
	inlinehv_id int(11) not null unique,		-- 输入侧过压状态
	inlinelv_id int(11) not null unique,		-- 输入侧欠压状态
	cvhtalarm_id int(11) not null unique,		-- 变压器超温报警状态
	cvlgalarm_id int(11) not null unique,   	-- 变压器轻瓦斯报警状态
	cvhgalarm_id int(11) not null unique,   	-- 变压器重瓦斯报警状态
	cvpressalarm_id int(11) not null unique,   	-- 变压器压力报警状态
	vconrtoltype_id int(11) not null unique,   	-- 电压控制类型(自动，手动)
	-- //
	-- added by zsh 2014-03-24 start for SVG调节模式状态
	svgconstatus_id	int(11) not null unique,			-- SVG控制模式(1-default, 1-电压自动跟踪模式, 2-指定无功模式)
	-- added by zsh 2014-03-24 start for SVG调节模式状态
	-- 模拟量
	netv_id int(11) not null unique,       	-- 电网电压(KV)
	neti_id int(11) not null unique,       	-- 电网电流(A)
	svgi_id int(11) not null unique,       	-- svg电流(A)
	sysp_id int(11) not null unique,       	-- svg数值：系统有功 (MW)
	sysq_id int(11) not null unique,       	-- svg数值：系统无功 (MVar)
	sysappp_id int(11) not null unique,       	-- svg数值：系统视在功率 (MVA)
	syspfac_id int(11) not null unique,       	-- svg数值：系统系统功率因数
	qadjhlimit_id int(11) not null unique,       -- svg数值：无功可调上限(MVar)
	qadjllimit_id int(11) not null unique,      -- svg数值：无功可调下限(MVar)
	vadjhlimit_id int(11) not null unique,       -- svg数值：电压可调上限(KV)
	vadjllimit_id int(11) not null unique,      -- svg数值：电压可调下限 (KV)
	-- //
	-- added by zsh 2014-03-24 start for SVG实时无功
	svgq_id int(11) not null unique,       	-- svg实时输出无功数值(MVar)
	-- added by zsh 2014-03-24 start for SVG实时无功
-- 遥调
	targetv_id int(11) not null unique,       	-- svg数值：电压调节目标指令(KV)
	-- //
	-- added by zsh 2014-03-24 start for SVG目标无功
	svgtargetq_id int(11) not null unique,       	-- svg目标无功数值(MVar)
	-- added by zsh 2014-03-24 start for SVG目标无功
-- 遥控
	-- added by zsh 2014-03-24 start for SVG调节模式状态,两种模式互斥,需要启用相应模式时,只需要开启对应模式
	svgcontrolmod_id 		int(11) not null unique,		-- SVG模式控制				(default-0, 1-切换为电压模式、2-切换无功模式)
	-- added by zsh 2014-03-24 start for SVG调节模式状态,两种模式互斥,需要启用相应模式时,只需要开启对应模式
-- 用户设置
	deadareav_id int(11) not null unique,	-- 目标电压死区(KV)
	adjmaxarea_id int(11) not null unique,	-- 调节偏差范围(KV)
	standardv_id int(11) not null unique,	-- 标准电压(KV)
	conintertime_id	int(11) not null unique,	-- 控制间隔时间ID(default 30s、距离上次调控的最小时间)(s)
	svgmodstatus_id int(11) not null unique,	-- svg模式状态(1-参与全场控制，AGC可以控制，2-不参与全场控制， 3-用户单独控制)
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS svcinfo;
create table svcinfo
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,		-- svcID
	svcname VARCHAR(64)  CHARACTER SET utf8 not null,		-- svc名称
-- 状态量
	run_id int(11) not null unique,		-- 运行状态
	error_id int(11) not null unique,	       	-- 故障状态
	ready_id int(11) not null unique,		-- 就绪状态
	breakersta_id int(11) not null unique,	-- 断路器状态
	hdiscsta_id int(11) not null unique,		-- 上级接地刀闸状态
	hisosta_id int(11) not null unique,		-- 上级隔离开关状态
	inlinehv_id int(11) not null unique,		-- 输入侧过压状态
	inlinelv_id int(11) not null unique,		-- 输入侧欠压状态
	cvhtalarm_id int(11) not null unique,	-- 变压器超温报警状态
	cvlgalarm_id int(11) not null unique,   	-- 变压器轻瓦斯报警状态
	cvhgalarm_id int(11) not null unique,   	-- 变压器重瓦斯报警状态
	cvpressalarm_id int(11) not null unique,   	-- 变压器压力报警状态
	vconrtoltype_id int(11) not null unique,   	-- 电压控制类型(自动，手动)
-- 模拟量
	netv_id int(11) not null unique,       	-- 电网电压(KV)
	neti_id int(11) not null unique,       	-- 电网电流(A)
	svci_id int(11) not null unique,       	-- svc电流(A)
	sysp_id int(11) not null unique,       	-- svc数值：系统有功(MW)
	sysq_id int(11) not null unique,       	-- svc数值：系统无功(MVar)
	sysappp_id int(11) not null unique,       	-- svc数值：系统视在功率(MVA)
	syspfac_id int(11) not null unique,       	-- svc数值：系统系统功率因数
	qadjhlimit_id int(11) not null unique,       -- svc数值：无功可调上限(MVar)
	qadjllimit_id int(11) not null unique,      -- svc数值：无功可调下限(MVar)
	vadjhlimit_id int(11) not null unique,       -- svc数值：电压可调上限(KV)
	vadjllimit_id int(11) not null unique,      -- svc数值：电压可调下限(KV)
-- 遥调
	targetv_id int(11) not null unique,       	-- svc数值：电压调节目标指令(KV)
-- 用户设置
	deadareav_id int(11) not null unique,	-- 目标电压死区(KV)
	adjmaxarea_id int(11) not null unique,	-- 调节偏差范围(KV)
	standardv_id int(11) not null unique,	-- 标准电压(KV)
	conintertime_id	int(11) not null unique,	-- 控制间隔时间ID(距离上次调控的最小时间)(s)
	svcmodstatus_id int(11) not null unique,	-- avc模式状态(1-参与全场控制，AGC可以控制，2-不参与全场控制， 3-用户单独控制)(s)
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS itinfo;
create table itinfo
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 逆变器ID
	itname VARCHAR(64)  CHARACTER SET utf8 not null,		-- 逆变器名称
	ittype VARCHAR(64)  CHARACTER SET utf8 not null,		-- 逆变器型号
	runtime int(11),			-- 并网时间
	runcap float(18,6),                -- 装机容量(KW)
-- -接口写入数据
	p_id int(11) not null unique,		-- 有功tagID(KW)
	q_id int(11) not null unique,		-- 无功tagID(KVar)
	tp_id int(11) not null unique,		-- 理论有功ID(KW)
	itv_id int(11) not null unique,		-- 逆变器电压ID(KW)
	rcap_id int(11) not null unique,		-- 实时开机容量ID(KW)
	rpower_id int(11) not null unique,		-- 日累计电量ID(KWH)
	tpower_id int(11) not null unique,		-- 日理论电量ID(KWH)
	-- start_id int(11) not null unique,	-- 逆变器开关(default 0、1-打开、2-关闭)
	runstatus_id int(11) not null unique,	-- 逆变器运行状态ID(default 0、 1-正常，2-停机，3-限功率停机，4-故障 ，5-限功率，6-通讯中断  )
	itfact_id int(11) not null unique,      -- 功率因数
	clid int(11) default 1 not null,
	ws_id int(11) not null unique,			-- 风向
	wv_id int(11) not null unique,			-- 风速
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS itagc;
create table itagc
(
	itid int(11) unsigned NOT NULL AUTO_INCREMENT,		-- 逆变器ID
	targetp_id int(11) not null unique,		-- 逆变器目标出力ID(KW)
    -- itrunmod_id int(11) not null unique,		-- 逆变器agc模式ID(1-参与全场控制，AGC可以控制，2-不参与全场控制， 3-用户单独控制)
	itmodstatus_id int(11) not null unique,	-- 逆变器agc模式状态(1-参与全场控制，AGC可以控制，2-不参与全场控制， 3-用户单独控制)  ///
-- 用户配置
	conintertime_id	int(11) not null unique,	-- 控制间隔时间ID(距离上次调控的最小时间)(s)
	phlimit_id int(11) not null unique,		-- 逆变器出力上限ID(KW)
	pllimit_id int(11) not null unique,		-- 逆变器出力下限ID(KW)
	-- ephlimit_id int(11) not null unique,		-- 逆变器经济出力上限ID(暂时保留)(KW)
	-- epllimit_id int(11) not null unique,		-- 逆变器经济出力下限ID(暂时保留)(KW)
	pdeadarea_id int(11) not null unique,	-- 逆变器出力控制死区ID(KW)
	fprocmax_id int(11) not null unique,		-- 逆变器出力最大功率变化率ID(容量%/次)
	-- fpcrocmax_id int(11) not null unique,	-- 集电线路出力持续最大功率变化率(%额定容量/min)
	-- agcuupv_id int(11) not null unique,		-- 逆变器升出力响应速度(MW/min)ID
	-- agcudpv_id int(11) not null unique,		-- 逆变器降出力响应速度(MW/min)ID
-- 新添加
	start_id int(11) not null unique,	-- 逆变器开关(default 0、1-打开、2-关闭)
	ashutdown_id int(11) not null unique,		-- 是否允许打开或关闭逆变器(default 1、1-允许、2不允许)
	-- FOREIGN KEY (itid) REFERENCES itinfo(id)
	PRIMARY KEY (`itid`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS itavc;
create table itavc
(
	itid int(11) unsigned NOT NULL AUTO_INCREMENT,		-- 逆变器ID
	targetq_id int(11) not null unique,		-- 目标无功值(KVar)
	targetv_id int(11) not null unique,		-- 目标电压值(KV)
    -- itrunmod_id int(11) not null unique,		-- 逆变器avc模式ID(1-参与全场控制，AVC可以控制，2-不参与全场控制， 3-用户单独控制)
	itmodstatus_id int(11) not null unique,	-- 逆变器avc模式状态(1-参与全场控制，AGC可以控制，2-不参与全场控制， 3-用户单独控制)  ///5
-- 用户设置
	targetfact_id int(11) not null unique,	-- 目标功率因数
	regulatetype_id int(11) not null unique,	-- 调控逆变器方式(default 1，1-无功、2-功率因数)
	avccontype_id int(11) not null unique,	-- avc对该逆变器是否无功控制(设置值，1-逆变器可以无功控制，2-逆变器不可无功控制)
	fminr_id int(11) not null unique,    	-- 无功分钟级变化率(KVar/min)
	frace_id int(11) not null unique,    	-- 无功单次变化率(KVar/次)
	qhlimit_id int(11) not null unique,		-- 逆变器无功上限(KVar)
	qllimit_id int(11) not null unique,		-- 逆变器无功下限(KVar)
	vhlimit_id int(11) not null unique,		-- 逆变器电压上限(KVar)
	vllimit_id int(11) not null unique,		-- 逆变器电压下限(KVar)
	qdeadarea_id int(11) not null unique,	-- 逆变器无功设置死区(用户设置值)(KVar)
	adjmaxarea_id int(11) not null unique,	-- 调节偏差范围(KVar)
	avcintertime_id	int(11) not null unique,	-- 控制间隔时间ID(default 30s、距离上次调控的最小时间)(s)
	-- FOREIGN KEY (itid) REFERENCES itinfo(id)
	itsfact_id int(11) not null unique,  -- 逆变器功率因数配置
	targetpf_id int(11) not null unique,  -- 逆变器avc目标功率因数值
	-- added by xuewu.zhou 2015-07-02 start
	contdotmod_id int(16) not null unique,			-- 逆变器控制模式(default 2-初始值，2 无功模式，3 功率因数模式，1 电压模式)
	dotmodstatus_id int(16) not null unique,		-- 逆变器模式状态(default 2-初始值，2 无功模式，3 功率因数模式，1 电压模式)
	-- added by xuewu.zhou 2015-07-02 end
	PRIMARY KEY (`itid`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS bstationtie;
create table bstationtie
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,		-- 升压站分接头ID
	bstname VARCHAR(64)  CHARACTER SET utf8 not null,			-- bst名称
	targetpos_id int(11) not null unique,	-- 目标档位
	posnum_id int(11) not null unique,		-- 档位个数(default 5)
	avcintertime_id	int(11) not null unique,	-- 控制间隔时间ID(default 120s、距离上次调控的最小时间)(s)
	bstmodstatus_id int(11) not null unique,	-- avc模式状态(1-参与全场控制，AGC可以控制，2-不参与全场控制， 3-用户单独控制)
	posrunstatus_id int(11) not null unique,      -- 分接头的运行状态(1-default,1、正常 2、故障)
	bstieihlimit_id int(11) not null unique,	-- 档位上限(default 35)
	bstieillimit_id int(11) not null unique,	-- 档位下限(default 1)
	unableadd_id int(11) not null unique,	-- 分接头增闭锁(0-default, 1-增闭锁，2-增允许)
	unablesub_id int(11) not null unique,	-- 分接头减闭锁(0-default, 1-减闭锁，2-减允许)
	tiedevation_id int(11) not null unique,	-- 档位偏差范围(default 3)
	-- start_id int(11) not null unique,	-- 分接头开关(default 0、1-打开、2-关闭)
	ashutdown_id int(11) not null unique,		-- 是否允许分接头档位可调(default 1、1-允许、2不允许)
-- 遥控
	-- added by zsh 2014-03-24 start for 分接头档位控制
	btiecontrol_id 		int(11) not null unique,		-- 主变压器分接头升档、降档控制(default-0 1-升档 2-降档)
	-- added by zsh 2014-03-24 end for 分接头档位控制
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS bstationpos;
create table bstationpos
(
	id 		int(11) unsigned NOT NULL AUTO_INCREMENT,		-- ID
	bstid		int(11) not null,				-- 分接头ID
	posnumber 	int(11) not null,				-- 档位编号
	pos_id		int(11) not null unique,			-- 档位值
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (bstid) REFERENCES bstationtie(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--  数据点表
DROP TABLE IF EXISTS point;
create table point
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	--  tag点ID
	name		varchar(128) CHARACTER SET utf8 not null,	--  点名称
	description	varchar(128) CHARACTER SET utf8 not null,					--  描述
	sourcetype  int(11) not null,		--  数据的写入来源(1-用户配置， 2-系统接口写入数据, 3-系统数据不需配置, 4-计算后读写)
	parenttype	int(11) not null,			--  基类类型(1-电场，2-AGC, 3-fdinfo)
	parentid	int(11) not null,			--  基类ID
	pointtype	int(11) not null,			--  tag点类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型
--  (int), 6-遥调整型(int))
	needarchive	int(11) not null,			--  是否归档(default 1、1-归，2-不归)
	artime	int(11),							--  归档最新时间
	sntime	int(11),							--  snapshot最新时间
	sndvalue	float(18,6),					--  double类型snapshot最新值
	snivalue	int(11),						--  int型snapshot最新值
	arcdvalue	float(18,6),					--  double类型归档最新值
	arcivalue	int(11),						--  整形归档最新值
	arcquality	int(11),						--  归档数据的质量
	snquality	int(11),						--  snapshot数据质量(default 1，1-正常 ，2-异常, 3-上下限判定)
	timeout		int(11) not null,			--  数据超时时间(default 300s)
	--  zuewu.zhou 2013-09-23
	--  llimit		float(18,6) not null,		--  数据下限
	--  hlimit		float(18,6) not null,		--  数据上限
	cmpdev		float(18,6) not null,			--  压缩死区(默认0.1)
	cmpmintime	int(11),						--  归档压缩最小间隔(默认1秒)
	cmpmaxtime	int(11),						--  归档压缩最大间隔(1200秒)
	--  //
	--  add start by zsh for alarm 2013-09-04
  	ifalarm int(11) not null,				--  是否告警(default 2、1-告警，2-不告警)
  	alarmlevel int(11),  					--  告警级别(1-正常，2-警告，3-严重，4-致命)
  	hlimit float(18,6),						--  遥测告警上限(越限作【alarmlevel】告警，回归正常做【正常】告警)
  	llimit float(18,6),						--  遥测告警下限(越限作【alarmlevel】告警，回归正常做【正常】告警)
  	alarmref int(11), 						-- 遥信状态正常参考值(遥信状态从【正常】变化至【不正常】设置【alarmlevel】告警、遥信状态从【不正常】变化至【正常】设置【正常】告警)
	-- add end by zsh for alarm 2013-09-04
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 历史表
DROP TABLE IF EXISTS pointarch;
create table pointarch
(
	id 	int(11) unsigned NOT NULL AUTO_INCREMENT,		-- 自动增长ID
	pointid	int(11)	not null,				-- tag点ID
	datatime int(11)	not null,				-- 数据值时间
	dvalue	float(18,6),						-- value值
	ivalue	int(11),							-- value值
	quality	int(11) not null,					-- 质量码
	-- FOREIGN KEY (id) REFERENCES point(id)
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agc命令表
DROP TABLE IF EXISTS agccmd;
create table agccmd
(
	id	int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	archid	int(11) unsigned NOT NULL,		-- 归档表ID
	commandsender	int(11) not null,		-- 命令发送模块 (1通道调度、2界面手动、3计划)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整--型--(int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	dvalue		float(18,6) NOT NULL DEFAULT -999999,					-- 遥调命令数值(-999999:表示值时ivalue)
	ivalue		int(11) NOT NULL DEFAULT -999999,						-- 遥控命令数值(-999999:表示值时dvalue)
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理，默认120秒，2分--钟
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	ovalue		float(18,6),				-- 上一个有功命令目标值(MW)
	adtime 		int(11),					-- 达到死区花费的时间(S)
	preci		float(18,6),				-- 精度(MW)
	stacoef 	float(6,2),					-- 稳定系数(取值在0~100之间，表示从命令开始到命令结束在死区内占比)
	anal		int(4),						-- 调节描述(调节分析)
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agc整数命令归档表
DROP TABLE IF EXISTS agcicmdarch;
create table agcicmdarch
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	commandsender	int(11) not null,		-- 命令发送模块 (1通道调度、2界面手动、3计划)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型----(--int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	ivalue		int(11),						-- 遥控命令数值
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (id) REFERENCES agccmd(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agc浮点命令归档表
DROP TABLE IF EXISTS agcdcmdarch;
create table agcdcmdarch
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	commandsender	int(11) not null,		-- 命令发送模块 (1通道调度、2界面手动、3计划)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型----(--int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	dvalue		float(18,6),				-- 遥调命令数值
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理
	status		int(11) not null,			-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	ovalue		float(18,6),				-- 上一个有功命令目标值(MW)
	adtime 		int(11),					-- 达到死区花费的时间(S)
	preci		float(18,6),				-- 精度(MW)
	stacoef 	float(6,2), 					-- 稳定系数(取值在0~100之间，表示从命令开始到命令结束在死区内占比)
	anal		int(4),						-- 调节描述(调节分析，取值为agcanalysis主键)
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (id) REFERENCES agccmd(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agc命令统计分析表
DROP TABLE IF EXISTS agcdcmdaly;
create table agcdcmdaly
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	alytime		datetime not null,			-- 最新更新时间
	nnumber		int(11),					-- 统计分析命令个数
	adtime 		int(11),					-- 达到死区花费的时间(S)
	preci		float(18,6),				-- 精度(MW)
	stacoef 	float(6,2),					-- 稳定系数(取值在0~100之间，表示从命令开始到命令结束在死区内占比)
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (id) REFERENCES agccmd(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agccmd表调节分析描述
DROP TABLE IF EXISTS agcanalysis;
create table agcanalysis
(
	id int(4) unsigned not null,	-- 主键
	desp VARCHAR(128) not null,		--  描述
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agc下位机发命令表
DROP TABLE IF EXISTS agclowercmd;
create table agclowercmd
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	commandsender	int(11) not null,		-- 命令发送模块(4-策略下发，切馈线，5-策略下发，下发给agc)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型----(--int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	dvalue		float(18,6),					-- 遥调命令数值
	ivalue		int(11),						-- 遥控命令数值
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	PRIMARY KEY (`id`)
)ENGINE=MEMORY AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agc下位机发命令表归档表
DROP TABLE IF EXISTS agclowercmdarch;
create table agclowercmdarch
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	commandsender	int(11) not null,		-- 命令发送模块(4-策略下发，切馈线，5-策略下发，下发给agc)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型----(--int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	dvalue		float(18,6),					-- 遥调命令数值
	ivalue		int(11),						-- 遥控命令数值
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (id) REFERENCES agclowercmd(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- avc命令表
DROP TABLE IF EXISTS avccmd;
create table avccmd
(
	id	int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	archid	int(11) unsigned NOT NULL,		-- 归档表ID
	commandsender	int(11) not null,		-- 命令发送模块 (1远方电压、2界面电压、3计划、7远方无功、8界面无功、9远方功率因数、10界面功率因数)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整--型--(int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	dvalue		float(18,6) NOT NULL DEFAULT -999999,					-- 遥调命令数值(-999999:表示值时ivalue)
	ivalue		int(11) NOT NULL DEFAULT -999999,						-- 遥控命令数值(-999999:表示值时dvalue)
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理，默认120秒，2分--钟
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	ovalue		float(18,6),				-- 上一个有功命令目标值(KV,Kavr,$)
	adtime 		int(11),					-- 达到死区花费的时间(S)
	preci		float(18,6),				-- 精度(MW)
	stacoef 	float(6,2), 					-- 稳定系数(取值在0~100之间，表示从命令开始到命令结束在死区内占比)
	anal		int(4),						-- 调节描述(调节分析)
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- avc命令归档表
DROP TABLE IF EXISTS avcicmdarch;
create table avcicmdarch
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	commandsender	int(11) not null,		-- 命令发送模块 (1通道调度、2界面手动、3计划)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型----(--int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	ivalue		int(11),						-- 遥控命令数值
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (id) REFERENCES avccmd(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agc命令归档表
DROP TABLE IF EXISTS avcdcmdarch;
create table avcdcmdarch
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	commandsender	int(11) not null,		-- 命令发送模块 (1通道调度、2界面手动、3计划)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型----(--int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	dvalue		float(18,6),					-- 遥调命令数值
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	ovalue		float(18,6),				-- 上一个有功命令目标值(KV,Kavr,$)
	adtime 		int(11),					-- 达到死区花费的时间(S)
	preci		float(18,6),				-- 精度(MW)
	stacoef 	float(6,2), 					-- 稳定系数(取值在0~100之间，表示从命令开始到命令结束在死区内占比)
	anal		int(4),						-- 调节描述(调节分析)
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (id) REFERENCES agccmd(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- agc命令统计分析表
DROP TABLE IF EXISTS avcdcmdaly;
create table avcdcmdaly
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	alytime		datetime not null,			-- 最新更新时间
	nnumber		int(11),					-- 统计分析命令个数
	adtime 		int(11),					-- 达到死区花费的时间(S)
	preci		float(18,6),				-- 精度(KV)
	stacoef 	float(6,2), 					-- 稳定系数(取值在0~100之间，表示从命令开始到命令结束在死区内占比)
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (id) REFERENCES agccmd(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- avccmd表调节分析描述
DROP TABLE IF EXISTS avcanalysis;
create table avcanalysis
(
	id int(4) unsigned not null,	--	主键
	desp VARCHAR(128) not null,		--  描述
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- avc下位机发命令表
DROP TABLE IF EXISTS avclowercmd;
create table avclowercmd
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	commandsender	int(11) not null,		-- 命令发送模块(4-策略下发，切馈线，5-策略下发，下发给agc)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型----(--int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	dvalue		float(18,6),					-- 遥调命令数值
	ivalue		int(11),						-- 遥控命令数值
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	PRIMARY KEY (`id`)
)ENGINE=MEMORY AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- avc下位机发命令表归档表
DROP TABLE IF EXISTS avclowercmdarch;
create table avclowercmdarch
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	commandsender	int(11) not null,		-- 命令发送模块(4-策略下发，切馈线，5-策略下发，下发给agc)
	commandtype	int(11) not null,			-- 命令类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double) 5-遥测整型----(--int), 6-遥调整型(int))
	datatime	int(11) not null,			-- 命令产生时间
	dvalue		float(18,6),					-- 遥调命令数值
	ivalue		int(11),						-- 遥控命令数值
	objectid	int(11) not null,			-- 命令针对的对象ID(point id)
	timeout		int(11) not null,			-- 命令超时时间，现在时间减去命令产生时间，若超过该时间，则该命令失效，不必处理
	status		int(11) not null,				-- 命令状态(0-未处理，1-处理中，2-处理完毕，3-处理失败，4-处理成功，5-因超时失效不做处理)
	PRIMARY KEY (`id`)
	-- FOREIGN KEY (id) REFERENCES agclowercmd(id)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 系统报警表
DROP TABLE IF EXISTS sysalarm;
create table sysalarm
(
	id		int(11)  unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	-- tag			int(11) not null,		-- 与恢复正常事件对应字段    -----
	targetId    int(11) not null,        	-- 事件对象ID
	-- occurtime	int(11) not null,			-- 异常产生时间（数据最新更新时间）
	alarmtime   int(11) not null,			-- 告警产生时间（记录本次插入告警时间）
	occurvalue	float(18,6) not null,			-- 产生时值	----
	-- limittag	int(11) not null,			-- 超上限还是下限(default 0,1-超上限、超下限)
	-- limitvalue	float(18,6) not null,		-- 最大极限值                    -----
	elevel 		int(11) ,					-- 事件等级(1-正常，2-警告，3-严重，4-致命)
	alarmtype	int(11) not null,			-- 事件类型(1-归档服务、2-后台管理服务、3-AGC调度接口、4-页面)
	subtype		int(11) not null,			-- 事件子类型(暂未设置)
	econtent	varchar(256) CHARACTER SET utf8 not null,			-- 事件内容
	ifconfirmed	int(11) not null,			-- 是否被用户确认(0-未确认，1-确认)
	username	VARCHAR(128) CHARACTER SET utf8,					-- 确认用户名
	PRIMARY KEY (`id`)
)ENGINE=MEMORY AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 告警归档表
DROP TABLE IF EXISTS sysalarmarch;
create table sysalarmarch
(
	id		int(11)  unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	targetId    int(11) not null,        	-- 事件对象ID
	occurtime	int(11) not null,			-- 产生时间
	-- archtime	int(11) not null,			--归档时间
	occurvalue	float(18,6) not null,			-- 产生时值
	-- limitvalue	float(18,6) not null,		--最大极限值
	elevel 		int(11) not null,			-- 事件等级(1-正常，2-警告，3-严重，4-致命)
	alarmtype	int(11) not null,			-- 事件类型(1-归档服务、2-后台管理服务、3-AGC调度接口、4-页面)
	subtype		int(11) not null,			-- 事件子类型(暂未设置)
	econtent	varchar(256) CHARACTER SET utf8 not null,			-- 事件内容
	ifconfirmed	int(11) not null,			-- 是否被用户确认(0-未确认，1-确认)
	username	VARCHAR(128) CHARACTER SET utf8,					-- 确认用户名
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 操作事件表
DROP TABLE IF EXISTS syscevent;
create table syscevent
(
	id		int(11)  unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	occurtime	int(11) not null,			-- 产生时间
	username	VARCHAR(128) CHARACTER SET utf8 not null,			-- 操作用户名
	eventtype	int(11) not null,			-- 事件类型(1-参数配置、2-控制命令、3-用户事件)
	subtype		int(11),						-- 事件子类型(1-电场，2-集电线，3-逆变器，4-馈线，0-其他)
	econtent	varchar(256) CHARACTER SET utf8 not null,			-- 事件内容
	targetId    int(11),            			-- 事件对象ID
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 系统服务表
-- modified by zsh 2013-09-04 for 服务状态修改 start
DROP TABLE IF EXISTS sysservice;
create table sysservice
(
	id	int(11) unsigned NOT NULL AUTO_INCREMENT,		-- 自动增长ID
	occurtime int(11) not null,				-- 产生时间
	srvname	VARCHAR(128) CHARACTER SET utf8 not null,				-- 服务名称(spmonitor spagc spavc sparchive spcom)
	srvtype	int(11) not null,				-- 服务类型(1-监测服务 2-AGC服务 3-AVC服务 4-归档服务 5-通信服务)
	desp 	VARCHAR(128) CHARACTER SET utf8 not null,				-- 服务描述(监测服务,AGC服务,AVC服务,归档服务,通信服务)
	srvstatus int(11) not null,				-- 服务状态(0-未启动, 1-启动)
	cpuval	float(18,6) not null,				-- CPU占用量(0~100)
	memoryval float(18,6),						-- 内存量，单位MB
	srvreboot int(11),						-- 服务重启标记(0：正常, 1：重启)
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
-- modified by zsh 2013-09-04 for 服务状态修改 start

-- 通讯状态表
DROP TABLE IF EXISTS commstatus;
create table commstatus
(
	id		int(11)  unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	-- 由界面添加通道
	name		VARCHAR(128) CHARACTER SET utf8 not null,          -- 通道名称(通道类型,可作通道描述使用,比如：调度AGC或AVC通道 调度AGC通道 调度AVC通道 逆变器通道 SVG或者SVC通道)
	-- modified by zsh 2013-09-04 start
	commtype	int(11) not null,			-- 通道类型(1-调度AGC或AVC共用通道、2-调度AGC通道、3-调度AGC通道、4-逆变器(风机)通道、5-SVG/SVC通道)
	-- modified by zsh 2013-09-04 end
	-- 由界面添加通道
	commstatus	int(11) not null,			-- 通道状态(1-开通、2-关闭)
	occurtime	int(11) not null,				-- 最新状态更新时间
	avtime		int(11),					-- 可用时间(s)
	navtime		int(11),					-- 不可用时间(s)
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 数据流缓冲区
DROP TABLE IF EXISTS databuff;
create table databuff
(
	id		int(11)  unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	srcid		int(11) not null,			-- 源ID
	datatime	int(11) not null,			-- 数据时间
	commandsender	int(11) not null,		-- 命令发送模块 (1、通道调度、2、界面手动、3、计划、4、策略下发的)
	datatype	int(11) not null,			-- 数据类型(1-遥信(int), 2-遥测浮点型(double), 3-遥控(int), 4-遥调浮点型(double),5-遥测整型----(--int--)，6-遥调整型(int))
	dvalue		float(18,6),					-- 浮点型数值
	ivalue		int(11),						-- 整形数值
	quality		int(11) not null,			-- 数据质量码(1-正常， 2-异常)
	flag  		int(11) not null,				-- 数据标志(1-插入、2-删除、3-修改)
	PRIMARY KEY (`id`)
)ENGINE=MEMORY AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 参数表
DROP TABLE IF EXISTS sysimp;
create table sysimp
(
	id		int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	calctime int(11) not null,				-- 更新时间
	systmpnum float(18,6) not null,            	-- 系统阻抗值
	PRIMARY KEY (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 版本表创建脚本
DROP TABLE IF EXISTS version;
create table version
(
	id			int(11)  unsigned NOT NULL AUTO_INCREMENT,-- 自动增长ID
	time			VARCHAR(128) CHARACTER SET utf8 not null,		-- 时间
	versionno		VARCHAR(128) CHARACTER SET utf8 not null,		-- 版本号
	content		varchar(256) CHARACTER SET utf8 not null,			-- 升级原因
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 策略记录表
DROP TABLE IF EXISTS strategy;
create table strategy
(
	id		int(11)  unsigned NOT NULL AUTO_INCREMENT,	-- 自动增长ID
	objectg  int(11) not null,				-- 表示策略是用于AGC还是AVC,1:AGC,2:AVC
	filename	VARCHAR(64) CHARACTER SET utf8 not null,			-- 动态库文件名
	time	VARCHAR(64) CHARACTER SET utf8 not null,				-- 时间
	strname VARCHAR(64) CHARACTER SET utf8 not null,            	-- 策略名称
	description	VARCHAR(2048) CHARACTER SET utf8,				-- 描述
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 添加集电线
DROP TABLE IF EXISTS collline;
create table collline
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,	-- 集电线ID
	name VARCHAR(64) CHARACTER SET utf8 not null,	-- 名称
	fid int(11) not null,		-- 电场ID
	allcapacity float(18,6) not null,		-- 装机容量
-- -接口写入数据
	p_id int(11) not null unique,		-- 总有功tagID
	q_id int(11) not null unique,		-- 总无功tagID
	ws_id int(11) not null unique,		-- 5分钟平均风速tagID
	wv_id int(11) not null unique,		-- 5分钟平均风向tagID
	tp_id int(11) not null unique,		-- 理论有功ID
	rcap_id int(11) not null unique,		-- 实际开机容量ID
	runnum_id int(11) not null unique,		-- 风机运行台数ID
	rpower_id int(11) not null unique,		-- 日累计电量ID
	tpower_id int(11) not null unique,		-- 日理论电量ID
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 有功分布图数据表
DROP TABLE IF EXISTS piedata;
create table piedata
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	srcid int(11) not null,			-- 源ID
	timedata DATE not null,		-- 时间YYYYMMDD
	One	int(6) not null,		-- 第一区间分布
	two	int(6) not null,		-- 第二区间分布
	three int(6) not null,		-- 第三区间分布
	four	int(6) not null,	-- 第四区间分布
	five	int(6) not null,	-- 第五区间分布
	six	int(6) not null,		-- 第六区间分布
	seven	int(6) not null,	-- 第七区间分布
	starttime datetime,	-- 发电起始时间
	endtime datetime,		-- 发电结束时间
	PRIMARY KEY (`id`)	
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 重要数据归档表
DROP TABLE IF EXISTS partition_pointarch;
create table partition_pointarch
(
	id    int(11) unsigned NOT NULL AUTO_INCREMENT,
	pointid    int(11)    not null,
	datatime int(11)    not null,
	dvalue    float(18,6),
	ivalue    int(11),
	quality    int(11) not null,
  PRIMARY KEY (id,datatime)
 )ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
partition by range(datatime)
(
	partition datatime_range_201501 values less than (1420041600),
	partition datatime_range_201502 values less than (1422720000),
	partition datatime_range_201503 values less than (1425139200),
	partition datatime_range_201504 values less than (1427817600),
	partition datatime_range_201505 values less than (1430409600),
	partition datatime_range_201506 values less than (1433088000),
	partition datatime_range_201507 values less than (1435680000),
	partition datatime_range_201508 values less than (1438358400),
	partition datatime_range_201509 values less than (1441036800),
	partition datatime_range_201510 values less than (1443628800),
	partition datatime_range_201511 values less than (1446307200),
	partition datatime_range_201512 values less than (1448899200),
	partition datatime_range_201601 values less than (1451577600),
	partition datatime_range_201602 values less than (1454256000),
	partition datatime_range_201603 values less than (1456761600),
	partition datatime_range_201604 values less than (1459440000),
	partition datatime_range_201605 values less than (1462032000),
	partition datatime_range_201606 values less than (1464710400),
	partition datatime_range_201607 values less than (1467302400),
	partition datatime_range_201608 values less than (1469980800),
	partition datatime_range_201609 values less than (1472659200),
	partition datatime_range_201610 values less than (1475251200),
	partition datatime_range_201611 values less than (1477929600),
	partition datatime_range_201612 values less than (1480521600),
	partition datatime_range_201701 values less than (1483200000),
	partition datatime_range_201702 values less than (1485878400),
	partition datatime_range_201703 values less than (1488297600),
	partition datatime_range_201704 values less than (1490976000),
	partition datatime_range_201705 values less than (1493568000),
	partition datatime_range_201706 values less than (1496246400),
	partition datatime_range_201707 values less than (1498838400),
	partition datatime_range_201708 values less than (1501516800),
	partition datatime_range_201709 values less than (1504195200),
	partition datatime_range_201710 values less than (1506787200),
	partition datatime_range_201711 values less than (1509465600),
	partition datatime_range_201712 values less than (1512057600),
	partition datatime_range_201801 values less than (1514736000),
	partition datatime_range_201802 values less than (1517414400),
	partition datatime_range_201803 values less than (1519833600),
	partition datatime_range_201804 values less than (1522512000),
	partition datatime_range_201805 values less than (1525104000),
	partition datatime_range_201806 values less than (1527782400),
	partition datatime_range_201807 values less than (1530374400),
	partition datatime_range_201808 values less than (1533052800),
	partition datatime_range_201809 values less than (1535731200),
	partition datatime_range_201810 values less than (1538323200),
	partition datatime_range_201811 values less than (1541001600),
	partition datatime_range_201812 values less than (1543593600),
	partition datatime_range_201901 values less than (1546272000),
	partition datatime_range_201902 values less than (1548950400),
	partition datatime_range_201903 values less than (1551369600),
	partition datatime_range_201904 values less than (1554048000),
	partition datatime_range_201905 values less than (1556640000),
	partition datatime_range_201906 values less than (1559318400),
	partition datatime_range_201907 values less than (1561910400),
	partition datatime_range_201908 values less than (1564588800),
	partition datatime_range_201909 values less than (1567267200),
	partition datatime_range_201910 values less than (1569859200),
	partition datatime_range_201911 values less than (1572537600),
	partition datatime_range_201912 values less than (1575129600),
	partition datatime_range_202001 values less than (1577808000),
	partition datatime_range_202002 values less than (1580486400),
	partition datatime_range_202003 values less than (1582992000),
	partition datatime_range_202004 values less than (1585670400),
	partition datatime_range_202005 values less than (1588262400),
	partition datatime_range_202006 values less than (1590940800),
	partition datatime_range_202007 values less than (1593532800),
	partition datatime_range_202008 values less than (1596211200),
	partition datatime_range_202009 values less than (1598889600),
	partition datatime_range_202010 values less than (1601481600),
	partition datatime_range_202011 values less than (1604160000),
	partition datatime_range_202012 values less than (1606752000),
	partition datatime_range_202101 values less than (1609430400),
	partition datatime_range_202102 values less than (1612108800),
	partition datatime_range_202103 values less than (1614528000),
	partition datatime_range_202104 values less than (1617206400),
	partition datatime_range_202105 values less than (1619798400),
	partition datatime_range_202106 values less than (1622476800),
	partition datatime_range_202107 values less than (1625068800),
	partition datatime_range_202108 values less than (1627747200),
	partition datatime_range_202109 values less than (1630425600),
	partition datatime_range_202110 values less than (1633017600),
	partition datatime_range_202111 values less than (1635696000),
	partition datatime_range_202112 values less than (1638288000),
	partition datatime_range_202201 values less than (1640966400),
	partition datatime_range_202202 values less than (1643644800),
	partition datatime_range_202203 values less than (1646064000),
	partition datatime_range_202204 values less than (1648742400),
	partition datatime_range_202205 values less than (1651334400),
	partition datatime_range_202206 values less than (1654012800),
	partition datatime_range_202207 values less than (1656604800),
	partition datatime_range_202208 values less than (1659283200),
	partition datatime_range_202209 values less than (1661961600),
	partition datatime_range_202210 values less than (1664553600),
	partition datatime_range_202211 values less than (1667232000),
	partition datatime_range_202212 values less than (1669824000),
	partition datatime_range_202301 values less than (1672502400),
	partition datatime_range_202302 values less than (1675180800),
	partition datatime_range_202303 values less than (1677600000),
	partition datatime_range_202304 values less than (1680278400),
	partition datatime_range_202305 values less than (1682870400),
	partition datatime_range_202306 values less than (1685548800),
	partition datatime_range_202307 values less than (1688140800),
	partition datatime_range_202308 values less than (1690819200),
	partition datatime_range_202309 values less than (1693497600),
	partition datatime_range_202310 values less than (1696089600),
	partition datatime_range_202311 values less than (1698768000),
	partition datatime_range_202312 values less than (1701360000),
	partition datatime_range_pmax values less than (maxvalue)
);
-- 新建数据表，用于界面显示
DROP TABLE IF EXISTS temporarydata;
create table temporarydata
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	dateV varchar(128) CHARACTER SET utf8 not null,		-- 时间
	OValue float(18,6),	  			-- 电压实时值
	OTarget float(18,6),			-- 电压目标值
	OUdead float(18,6),				-- 电压上限
	ODdead float(18,6),				-- 电压下限
	TValue float(18,6),  			-- 无功相关
	TTarget float(18,6),
	TUdead float(18,6),
	TDdead float(18,6),
	SValue float(18,6),	  			-- 功率因数相关
	STarget float(18,6),
	SUdead float(18,6),
	SDdead float(18,6),
	PValue float(18,6),	  			-- 有功相关
	PTarget float(18,6),
	PUdead float(18,6),
	PDdead float(18,6),
	PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
-- 新建存储过程用于向temporarydata存数据
drop procedure IF EXISTS INSERTtemporarydata;
DELIMITER //
CREATE PROCEDURE INSERTtemporarydata()  
BEGIN
	DECLARE dotmodstatus int;
	SELECT snivalue INTO dotmodstatus FROM point WHERE id = (SELECT dotmodstatus_id FROM avcsysinfo);
	case dotmodstatus
	when 1 then insert into temporarydata (dateV,OValue,OTarget,OUdead,ODdead,PValue,PTarget,PUdead,PDdead,TValue,SValue)VALUES (date_format(now(),'%Y-%c-%d %H:%i:%s'),(SELECT sndvalue FROM point WHERE id =3),(SELECT sndvalue FROM point WHERE id =22),((SELECT sndvalue FROM point WHERE id =22)+(SELECT sndvalue FROM point WHERE id = (SELECT deadareav_id FROM avcsysinfo))),((SELECT sndvalue FROM point WHERE id =22)-(SELECT sndvalue FROM point WHERE id = (SELECT deadareav_id FROM avcsysinfo))),(SELECT sndvalue FROM point WHERE id =1),(SELECT sndvalue FROM point WHERE id =71),((SELECT sndvalue FROM point WHERE id =71)+(SELECT sndvalue FROM point WHERE id = (SELECT pdeadarea_id FROM agcsysinfo))),((SELECT sndvalue FROM point WHERE id =71)-(SELECT sndvalue FROM point WHERE id = (SELECT pdeadarea_id FROM agcsysinfo))),(SELECT sndvalue FROM point WHERE id =2),(SELECT sndvalue FROM point WHERE id =29));
	when 2 then insert into temporarydata (dateV,TValue,TTarget,TUdead,TDdead,PValue,PTarget,PUdead,PDdead,OValue,SValue)VALUES (date_format(now(),'%Y-%c-%d %H:%i:%s'),(SELECT sndvalue FROM point WHERE id =2),(SELECT sndvalue FROM point WHERE id =22),((SELECT sndvalue FROM point WHERE id =22)+(SELECT sndvalue FROM point WHERE id = (SELECT deadareaq_id FROM avcsysinfo))),((SELECT sndvalue FROM point WHERE id =22)-(SELECT sndvalue FROM point WHERE id = (SELECT deadareaq_id FROM avcsysinfo))),(SELECT sndvalue FROM point WHERE id =1),(SELECT sndvalue FROM point WHERE id =71),((SELECT sndvalue FROM point WHERE id =71)+(SELECT sndvalue FROM point WHERE id = (SELECT pdeadarea_id FROM agcsysinfo))),((SELECT sndvalue FROM point WHERE id =71)-(SELECT sndvalue FROM point WHERE id = (SELECT pdeadarea_id FROM agcsysinfo))),(SELECT sndvalue FROM point WHERE id =3),(SELECT sndvalue FROM point WHERE id =29));
	when 3 then insert into temporarydata (dateV,SValue,STarget,SUdead,SDdead,PValue,PTarget,PUdead,PDdead,OValue,TValue)VALUES (date_format(now(),'%Y-%c-%d %H:%i:%s'),(SELECT sndvalue FROM point WHERE id =29),(SELECT sndvalue FROM point WHERE id =22),((SELECT sndvalue FROM point WHERE id =22)+(SELECT sndvalue FROM point WHERE id = (SELECT deadareaf_id FROM avcsysinfo))),((SELECT sndvalue FROM point WHERE id =22)-(SELECT sndvalue FROM point WHERE id = (SELECT deadareaf_id FROM avcsysinfo))),(SELECT sndvalue FROM point WHERE id =1),(SELECT sndvalue FROM point WHERE id =71),((SELECT sndvalue FROM point WHERE id =71)+(SELECT sndvalue FROM point WHERE id = (SELECT pdeadarea_id FROM agcsysinfo))),((SELECT sndvalue FROM point WHERE id =71)-(SELECT sndvalue FROM point WHERE id = (SELECT pdeadarea_id FROM agcsysinfo))),(SELECT sndvalue FROM point WHERE id =2),(SELECT sndvalue FROM point WHERE id =3));
	end case;
END;	//
DELIMITER ;
-- 新建存储过程，用于删除temporarydata表数据
drop procedure IF EXISTS DELETEtemporarydata;
DELIMITER //
CREATE PROCEDURE DELETEtemporarydata()  
BEGIN
	delete from temporarydata;
END;	//
DELIMITER ;
-- 每天凌晨删除temporarydata表前一天数据
CREATE EVENT IF NOT EXISTS deltemp
ON SCHEDULE EVERY 1 DAY STARTS '2016-01-01 00:00:00'
ON COMPLETION PRESERVE
DO CALL DELETEtemporarydata();
-- 每10s向temporarydata表存入数据
CREATE EVENT IF NOT EXISTS INtemp
ON SCHEDULE EVERY 10 SECOND
ON COMPLETION PRESERVE
DO CALL INSERTtemporarydata();
-- 开启定时服务
SET GLOBAL event_scheduler = 1; 

DROP TRIGGER IF EXISTS tr_upd_sysalarm;
DELIMITER ;;
CREATE TRIGGER tr_upd_sysalarm
   AFTER update ON sysalarm
   FOR EACH ROW
BEGIN
        update sysalarmarch set ifconfirmed=new.ifconfirmed,username=new.username where id=new.id;
END
;;
DELIMITER ;


DROP TRIGGER IF EXISTS tr_int_sysalarm;
DELIMITER ;;
CREATE TRIGGER tr_int_sysalarm
	AFTER INSERT ON sysalarmarch
	FOR EACH ROW
BEGIN
    INSERT INTO sysalarm VALUES (new.id, new.targetId, new.occurtime, new.occurvalue, new.elevel, new.alarmtype, new.subtype,new.econtent,new.ifconfirmed,new.username);
END
;;
DELIMITER ;


-- 删除agccmd命令触发，自动归档
DROP TRIGGER IF EXISTS tr_del_agccmd;
DELIMITER ;;
CREATE TRIGGER tr_del_agccmd
	before delete ON agccmd
	FOR EACH ROW
BEGIN
	if old.ivalue = -999999 then  
		INSERT INTO agcdcmdarch(commandsender,commandtype,datatime,dvalue,objectid,timeout,status,ovalue,adtime,preci,stacoef,anal) VALUES (old.commandsender,old.commandtype,old.datatime,old.dvalue,old.objectid,old.timeout,old.status,old.ovalue,old.adtime,old.preci,old.stacoef,old.anal);
	else
		INSERT INTO agcicmdarch(commandsender,commandtype,datatime,ivalue,objectid,timeout,status) VALUES (old.commandsender,old.commandtype,old.datatime,old.ivalue,old.objectid,old.timeout,old.status);
	end if;
END
;;
DELIMITER ;

-- 计算agc命令平均值统计存储过程
drop procedure IF EXISTS calc_agcdcmdarch_avg;
DELIMITER //
CREATE PROCEDURE calc_agcdcmdarch_avg()  
BEGIN  
DECLARE size int DEFAULT 0;
DECLARE adtimep int;
DECLARE precip DECIMAL(18,2) DEFAULT 0;
DECLARE stacoefp int;
DECLARE adtimey int;
DECLARE preciy DECIMAL(18,2) DEFAULT 0;
DECLARE stacoefy int;
DECLARE adtimet int;
DECLARE precit DECIMAL(18,2) DEFAULT 0;
DECLARE stacoeft int;
DECLARE nnumberp int;
select MAX(id) into size from agcdcmdarch;
select adtime,preci,stacoef into adtimep,precip,stacoefp from agcdcmdarch where id = size;
select adtime,preci,stacoef,nnumber into adtimey,preciy,stacoefy,nnumberp from agcdcmdaly where id = 1;
set adtimet := (adtimey*(size-1)+adtimep)/(size);
set precit := (preciy*(size-1)+precip)/(size);
set stacoeft := (stacoefy*(size-1)+stacoefp)/(size);
update agcdcmdaly set alytime=current_timestamp(),nnumber=(nnumberp+1),adtime=adtimet,preci=precit,stacoef=stacoeft where id = 1;
END;    //
DELIMITER ;


-- 计算agc命令平均值统计触发器
DROP TRIGGER IF EXISTS tr_calc_agcdcmdarch_avg;
DELIMITER ;;
CREATE TRIGGER tr_calc_agcdcmdarch_avg
	after INSERT ON agcdcmdarch
	FOR EACH ROW
BEGIN
    call calc_agcdcmdarch_avg();
END
;;
DELIMITER ;


-- 删除avccmd命令触发，自动归档
DROP TRIGGER IF EXISTS tr_del_avccmd;
DELIMITER ;;
CREATE TRIGGER tr_del_avccmd
	before delete ON avccmd
	FOR EACH ROW
BEGIN
	if old.ivalue = -999999 then  
		INSERT INTO avcdcmdarch(commandsender,commandtype,datatime,dvalue,objectid,timeout,status,ovalue,adtime,preci,stacoef,anal) VALUES (old.commandsender,old.commandtype,old.datatime,old.dvalue,old.objectid,old.timeout,old.status,old.ovalue,old.adtime,old.preci,old.stacoef,old.anal);
	else
		INSERT INTO avcicmdarch(commandsender,commandtype,datatime,ivalue,objectid,timeout,status) VALUES (old.commandsender,old.commandtype,old.datatime,old.ivalue,old.objectid,old.timeout,old.status);
	end if;
END
;;
DELIMITER ;

-- 计算avc命令平均值统计存储过程
drop procedure IF EXISTS calc_avcdcmdarch_avg;
DELIMITER //
CREATE PROCEDURE calc_avcdcmdarch_avg()  
BEGIN  
DECLARE size int DEFAULT 0;
DECLARE adtimep int;
DECLARE precip DECIMAL(18,2) DEFAULT 0;
DECLARE stacoefp int;
DECLARE adtimey int;
DECLARE preciy DECIMAL(18,2) DEFAULT 0;
DECLARE stacoefy int;
DECLARE adtimet int;
DECLARE precit DECIMAL(18,2) DEFAULT 0;
DECLARE stacoeft int;
DECLARE nnumberp int;
select MAX(id) into size from avcdcmdarch;
select adtime,preci,stacoef into adtimep,precip,stacoefp from avcdcmdarch where id = size;
select adtime,preci,stacoef,nnumber into adtimey,preciy,stacoefy,nnumberp from avcdcmdaly where id = 1;
set adtimet := (adtimey*(size-1)+adtimep)/(size);
set precit := (preciy*(size-1)+precip)/(size);
set stacoeft := (stacoefy*(size-1)+stacoefp)/(size);
update avcdcmdaly set alytime=current_timestamp(),nnumber=(nnumberp+1),adtime=adtimet,preci=precit,stacoef=stacoeft where id = 1;
END;    //
DELIMITER ;

-- 计算avc命令平均值统计触发器
DROP TRIGGER IF EXISTS tr_calc_avcdcmdarch_avg;
DELIMITER ;;
CREATE TRIGGER tr_calc_avcdcmdarch_avg
	after INSERT ON avcdcmdarch
	FOR EACH ROW
BEGIN
    call calc_avcdcmdarch_avg();
END
;;
DELIMITER ;

-- agclowercmd表归档触发器
DROP TRIGGER IF EXISTS tr_del_agclowercmd;
DELIMITER ;;
CREATE TRIGGER tr_del_agclowercmd
	before delete ON agclowercmd
	FOR EACH ROW
BEGIN
	INSERT INTO agclowercmdarch(commandsender,commandtype,datatime,dvalue,ivalue,objectid,timeout,status) VALUES (old.commandsender,old.commandtype,old.datatime,old.dvalue,old.ivalue,old.objectid,old.timeout,old.status);
END
;;
DELIMITER ;

-- avclowercmd表归档触发器
DROP TRIGGER IF EXISTS tr_del_avclowercmd;
DELIMITER ;;
CREATE TRIGGER tr_del_avclowercmd
	before delete ON avclowercmd
	FOR EACH ROW
BEGIN
	INSERT INTO avclowercmdarch(commandsender,commandtype,datatime,dvalue,ivalue,objectid,timeout,status) VALUES (old.commandsender,old.commandtype,old.datatime,old.dvalue,old.ivalue,old.objectid,old.timeout,old.status);
END
;;
DELIMITER ;





