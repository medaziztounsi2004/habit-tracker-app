# Testing Guide for Quit Habit System

## Prerequisites
1. Pull the latest changes from the PR
2. Run: `flutter pub run build_runner build --delete-conflicting-outputs`
3. Build and run the app on a device or emulator

## Test Scenarios

### Scenario 1: Create a Quit Habit
**Objective**: Verify quit habit creation with all fields

**Steps**:
1. Tap the + button to add a new habit
2. Tap "Quit Habit" toggle (should turn red)
3. Enter "Smoking" as the habit name
4. Enter "10.00" in the "Money Saved Per Day" field
5. Choose an icon (e.g., smoking icon)
6. Choose a color
7. Select category "Health"
8. Select all 7 days
9. Set a reminder time
10. Tap "Create Habit"

**Expected Results**:
- ✅ Toggle animates to red "Quit Habit"
- ✅ Money field appears below description
- ✅ Habit is created successfully
- ✅ Returns to home screen
- ✅ New section "Habits I'm Quitting" appears with red icon
- ✅ Quit habit card shows with timer starting at 0 days
- ✅ Timer displays 00:00:00:01, then 00:00:00:02, etc.

### Scenario 2: Verify Live Timer
**Objective**: Ensure timer updates every second

**Steps**:
1. Navigate to home screen
2. Observe the quit habit card timer
3. Wait 60 seconds

**Expected Results**:
- ✅ Seconds increment from 00 to 59
- ✅ At 60 seconds, minutes increment to 01
- ✅ Seconds reset to 00
- ✅ Timer continues updating without lag
- ✅ Timer shows correct format: DD:HH:MM:SS

### Scenario 3: Money Saved Display
**Objective**: Verify money calculation

**Steps**:
1. Wait at least 1 hour (or modify quitStartDate in database)
2. Check the money saved display

**Expected Results**:
- ✅ Money saved section visible
- ✅ Amount increases proportionally with time
- ✅ Calculation: (hours / 24) * moneySavedPerDay
- ✅ Displays with 2 decimal places

### Scenario 4: Milestone Badges
**Objective**: Verify milestone achievements

**Steps**:
1. For testing, modify quitStartDate in database to be:
   - 1 day ago
   - 3 days ago
   - 7 days ago
2. Restart app to see changes

**Expected Results**:
- ✅ 1 day badge appears after 1 day
- ✅ 3 days badge appears after 3 days
- ✅ 7 days badge appears after 7 days
- ✅ Badges show gold/orange gradient
- ✅ Badge text: "1 Day", "3 Days", "7 Days"

### Scenario 5: Panic Button - Stay Strong
**Objective**: Test panic modal and staying strong

**Steps**:
1. Tap orange "I'm Having an Urge" button
2. Observe modal content
3. Read the advice displayed
4. Note the "X days clean" reminder
5. Tap "I Stayed Strong" button

**Expected Results**:
- ✅ Modal slides up smoothly
- ✅ Shows days clean count
- ✅ Displays random advice about the habit
- ✅ Breathing exercise button visible
- ✅ "I Stayed Strong" button is green
- ✅ Modal closes when button tapped
- ✅ Timer continues unchanged

### Scenario 6: Breathing Exercise
**Objective**: Test breathing exercise integration

**Steps**:
1. Tap "I'm Having an Urge" button
2. Tap "Start 4-7-8 Breathing" button
3. Observe breathing exercise
4. Complete one cycle (4s in, 7s hold, 8s out)
5. Exit or complete all cycles

**Expected Results**:
- ✅ Modal closes
- ✅ Breathing exercise screen opens
- ✅ Circle expands/contracts with breathing
- ✅ Countdown shows for each phase
- ✅ Instructions show: "Breathe In", "Hold", "Breathe Out"
- ✅ Can return to home screen

### Scenario 7: Record Relapse
**Objective**: Test relapse recording and timer reset

**Steps**:
1. Note the current timer value (e.g., 2 days)
2. Tap "I'm Having an Urge" button
3. Scroll down to "I Slipped" button
4. Tap "I Slipped" (red outlined button)
5. Confirm in the dialog
6. Observe results

**Expected Results**:
- ✅ Confirmation dialog appears
- ✅ Dialog message is empathetic
- ✅ After confirming:
  - Timer resets to 00:00:00:00
  - Snackbar appears with encouragement
  - Modal closes
  - Relapse is recorded (check with database inspector)
- ✅ Milestone badges reset

### Scenario 8: Multiple Quit Habits
**Objective**: Ensure multiple quit habits work correctly

**Steps**:
1. Create 3 different quit habits:
   - Smoking ($10/day)
   - Alcohol ($15/day)
   - Social Media ($0/day)
2. Observe home screen

**Expected Results**:
- ✅ All 3 habits appear in "Habits I'm Quitting" section
- ✅ Each has its own timer
- ✅ All timers update independently
- ✅ Money saved shows only for Smoking and Alcohol
- ✅ Social Media doesn't show money saved section
- ✅ Section header shows once above all quit habits

### Scenario 9: Edit Quit Habit
**Objective**: Verify quit habit editing

**Steps**:
1. Create a quit habit
2. Navigate to habit list
3. Long press or tap edit on the quit habit
4. Change name to "Cigarettes"
5. Change money saved to "12.00"
6. Save changes

**Expected Results**:
- ✅ Edit screen opens
- ✅ "Quit Habit" toggle is already selected (red)
- ✅ Money field shows current value
- ✅ All fields populated correctly
- ✅ After saving:
  - Name updates on card
  - Money calculation updates
  - Timer continues from same point (not reset)

### Scenario 10: Build vs Quit Separation
**Objective**: Ensure build and quit habits are properly separated

**Steps**:
1. Create 2 build habits (e.g., "Exercise", "Meditate")
2. Create 2 quit habits (e.g., "Smoking", "Social Media")
3. Observe home screen

**Expected Results**:
- ✅ "Habits I'm Quitting" section shows ONLY quit habits
- ✅ "Today's Habits" section shows ONLY build habits
- ✅ Quit habits show timer
- ✅ Build habits show completion checkbox
- ✅ No overlap between sections

### Scenario 11: Delete/Archive Quit Habit
**Objective**: Verify quit habit removal

**Steps**:
1. Create a quit habit
2. Delete or archive it
3. Check home screen

**Expected Results**:
- ✅ Quit habit removed from "Habits I'm Quitting" section
- ✅ If no quit habits remain, section disappears
- ✅ "Today's Habits" section unaffected

### Scenario 12: No Quit Habits
**Objective**: Ensure clean display with no quit habits

**Steps**:
1. Ensure no quit habits exist (delete all)
2. Navigate to home screen

**Expected Results**:
- ✅ "Habits I'm Quitting" section doesn't appear
- ✅ Only "Today's Habits" section shows
- ✅ No empty states or errors

## Edge Cases to Test

### Edge Case 1: Zero Money Saved
**Steps**: Create quit habit with "0.00" money saved or leave blank

**Expected**: Money saved section doesn't appear on card

### Edge Case 2: Very Large Numbers
**Steps**: Enter "999.99" as money saved per day

**Expected**: Calculation works correctly, displays properly

### Edge Case 3: Invalid Money Input
**Steps**: Try entering letters in money field

**Expected**: Validation error appears, can't save

### Edge Case 4: Timer Accuracy
**Steps**: 
1. Create quit habit
2. Close app
3. Wait 5 minutes
4. Reopen app

**Expected**: Timer shows correct elapsed time including the 5 minutes

### Edge Case 5: Rapid Relapses
**Steps**: 
1. Create quit habit
2. Record relapse 3 times in a row
3. Check relapse history (database)

**Expected**: All 3 relapses recorded with timestamps

## Performance Tests

### Performance Test 1: Multiple Timers
**Steps**: Create 5 quit habits, observe for 5 minutes

**Expected**: 
- No lag or stuttering
- All timers update smoothly
- App remains responsive

### Performance Test 2: Long Duration
**Steps**: Set quit date to 1 year ago (database), observe timer

**Expected**: 
- Large numbers display correctly
- Money saved shows accurate high value
- No performance degradation

## Accessibility Tests

### Accessibility Test 1: Screen Reader
**Steps**: Enable TalkBack/VoiceOver

**Expected**: All buttons and text are announced correctly

### Accessibility Test 2: Large Text
**Steps**: Enable large text in device settings

**Expected**: UI adapts appropriately, no overflow

## Database Verification

Using a database inspector (e.g., Hive Viewer):

1. **Check Habit Fields**:
   - `isQuitHabit` is `true` for quit habits
   - `quitStartDate` is set to creation time
   - `moneySavedPerDay` matches entered value
   - `relapses` is empty array initially

2. **After Relapse**:
   - `relapses` array contains timestamp
   - `quitStartDate` updated to relapse time

## Regression Testing

Ensure existing features still work:

1. ✅ Regular habit creation
2. ✅ Habit completion/unchecking
3. ✅ Streak tracking
4. ✅ Calendar view
5. ✅ Statistics screen
6. ✅ Profile screen
7. ✅ Achievements
8. ✅ Notifications

## Bug Reporting Template

If you find a bug, report with:

```
**Bug Title**: [Clear, descriptive title]

**Steps to Reproduce**:
1. 
2. 
3. 

**Expected Behavior**: 

**Actual Behavior**: 

**Screenshots**: [If applicable]

**Device Info**:
- Device: 
- OS Version: 
- App Version: 

**Additional Context**: 
```

## Test Completion Checklist

- [ ] All 12 scenarios tested
- [ ] All 5 edge cases tested
- [ ] Performance tests completed
- [ ] Accessibility tests completed
- [ ] Database verification done
- [ ] Regression tests passed
- [ ] No critical bugs found
- [ ] Ready for production

## Notes

- Some tests require modifying the database for time-based features
- Use a database inspector tool for verification
- Test on both Android and iOS if possible
- Test on different screen sizes
- Document any issues found

---

**Happy Testing! 🧪**
