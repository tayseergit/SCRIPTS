import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/AddProject/View/Widget/add_project_header.dart';
import 'package:lms/Module/AddProject/View/Widget/custom_textField.dart';

import 'package:lms/Module/AddProject/View/Widget/file_upload_card.dart';
import 'package:lms/Module/AddProject/View/Widget/project_links_section.dart';
 import 'package:lms/Module/AddProject/View/Widget/custom_dropdown_field.dart';
import 'package:lms/Module/AddProject/View/Widget/custom_multi_select_dropdown.dart';
import 'package:lms/Module/AddProject/cubit/add_project_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
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
      child: BlocConsumer<AddProjectCubit, AddProjectState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = context.read<AddProjectCubit>();
          return Scaffold(
            backgroundColor: appColor.pageBackground.withOpacity(1),
            body: SafeArea(
              child: Column(
                children: [
                  const AddProjectHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FileUploadCard(),
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
                            items: cubit.tags,
                            onChanged: (String? newValue) {
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
