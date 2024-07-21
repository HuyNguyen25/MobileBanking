import 'package:application/database_services/core_service.dart';
import 'package:application/models/transaction.dart';
import 'package:application/models/user.dart';
import 'package:application/screens/history/notifiers/history_screen_notifier.dart';
import 'package:application/screens/history/widgets/history_item.dart';
import 'package:application/theme/theme.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends ConsumerState<HistoryScreen> {
  static const _pageSize = 10;
  final PagingController<int, Transaction> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(
        (pageKey) async {
          _fetchHistoryData(pageKey);
        }
    );

    BackButtonInterceptor.add(
      (stopDefaultButtonEvent, info) async {
        if(context.mounted) {
          Navigator.pushReplacementNamed(context, "/homeScreen");
        }
        return true;
      },
      name: "backButtonInterceptorFunctionForHistoryScreen"
    );
  }

  Future<void> _fetchHistoryData(int pageKey) async {
    final user = ref.read(historyScreenNotifier);
    final newTransactions = await CoreService.getTransaction(
      accountId: user!.accountId,
      page: pageKey~/_pageSize + 1,//the first page is page 1
      perPage: _pageSize
    );

    if(newTransactions.length < _pageSize) {//last page
      _pagingController.appendLastPage(newTransactions);
    }
    else{//otherwise
      _pagingController.appendPage(newTransactions, pageKey + newTransactions.length);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    BackButtonInterceptor.removeByName("backButtonInterceptorFunctionForHistoryScreen");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(historyScreenNotifier);
    return SafeArea(
      child: Scaffold(
        appBar: _buildHistoryScreenAppBar(context),
        body: _buildHistoryScreenBody(user, context)
      )
    );
  }

  PreferredSizeWidget _buildHistoryScreenAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.logout, color: CustomColors.gray900),
        onPressed: () async {
          if(context.mounted) {
            Navigator.pushReplacementNamed(context, "/homeScreen");
          }
        },
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(3),
        child: Container(
          height: 3,
          color: Colors.black
        ),
      ),
      title: Text("History", style: CustomTextStyles.titleMedium.copyWith(color: CustomColors.gray900)),
    );
  }

  Widget _buildHistoryScreenBody(User? user, BuildContext context) {
    return SizedBox(
      width: SizerUtil.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 2.h),
        child: PagedListView<int, Transaction> (
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Transaction> (
            itemBuilder: (context, item, index) {
              return HistoryItem(transaction: item);
            }
          ),
        ),
      ),
    );
  }
}
