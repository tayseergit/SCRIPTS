import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/AddProject/View/Widget/add_project_header.dart';
import 'package:lms/Module/AddProject/View/Widget/custom_textField.dart';

import 'package:lms/Module/AddProject/View/Widget/file_upload_card.dart';
import 'package:lms/Module/AddProject/View/Widget/project_links_section.dart';
import 'package:lms/Module/AddProject/View/Widget/custom_dropdown_field.dart';
import 'package:lms/Module/AddProject/View/Widget/custom_multi_select_dropdown.dart';
import 'package:lms/Module/AddProject/cubit/add_project_cubit.dart';
import 'package:lms/Module/Project/Model/tag_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  @override
  Widget build(BuildContext context) {
    var appColor = context.read<ThemeCubit>().state;
    var lang = S.of(context);

    return BlocProvider(
      create: (context) => AddProjectCubit()..getProjectsTags(context),
      child: Scaffold(
        backgroundColor: appColor.pageBackground.withOpacity(1),
        body: SafeArea(
          child: Column(
            children: [
              AddProjectHeader(),
              BlocConsumer<AddProjectCubit, AddProjectState>(
                listener: (context, state) {
                  if (state is FieldRrequired) {
                    customSnackBar(
                        context: context,
                        success: 0,
                        message: lang.fill_details);
                  }
                  if (state is FullMonthlyProjectError) {
                    customSnackBar(
                        context: context,
                        success: 2,
                        message: lang.cant_send_more_in_month);
                  } else if (state is AddProjectSuccess) {
                    Navigator.pop(context);
                    customSnackBar(
                        context: context,
                        success: 1,
                        message: lang.attent_admin_To_Accept);
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<AddProjectCubit>();
                  if (state is TagError) {
                    return NoConnection(
                      message: state.message,
                    );
                  } else if (state is TagsLoading) {
                    return Center(
                        heightFactor: 3,
                        child: Loading(
                          height: 200,
                          width: 200,
                        ));
                  }
                  return Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FileUploadCard(
                          //   cubit: cubit,
                          // ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: cubit.titleController,
                            label: lang.project_title,
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: cubit.descriptionController,
                            label: lang.project_description,
                            maxLines: 5,
                          ),
                          SizedBox(height: 20.h),
                          CustomDropdownField(
                            label: lang.project_kind,
                            hint: lang.select_a_tag,
                            value: cubit.selectedTag,
                            items: cubit.tagResponse!.tags,
                            onChanged: (TagModel? newValue) {
                              setState(() {
                                cubit.selectedTag = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 20.h),
                          CustomMultiSelectDropdown(
                            label: lang.technologies,
                            hint: lang.select_technologies,
                            selectedItems: cubit.selectedTechnologies,
                            availableItems: cubit.availableTechnologies,
                            onChanged: (String? value) {
                              setState(() {}); // Update the main state
                            },
                          ),
                          SizedBox(height: 20.h),
                          ProjectLinksSection(
                            gitHubController: cubit.gitHubController,
                            demoController: cubit.demoController,
                            steamController: cubit.steamController,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          state is AddProjectLoading
                              ? Center(
                                  child:
                                      SizedBox(height: 50.h, child: Loading()))
                              : OnBoardingContainer(
                                  onTap: () {
                                    cubit.AddProjects(context);
                                  },
                                  radius: 20.r,
                                  height: 60.h,
                                  color: appColor.primary,
                                  widget: AuthText(
                                      text: lang.next,
                                      size: 20.sp,
                                      color: appColor.mainText,
                                      fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
